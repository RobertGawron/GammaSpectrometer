#!/bin/bash
set -e

# ============================================================
# Unified Development Environment Entrypoint
# Gamma Spectrometer v2.0
# ============================================================

echo "========================================================"
echo "  🔬 Gamma Spectrometer Development Environment v2.0"
echo "========================================================"
echo ""
echo "Build Information:"
echo "  User:    $(whoami)"
echo "  Octave:  $(octave --version 2>/dev/null | head -n1 || echo 'Not available')"
echo "  Python:  $(python3 --version 2>/dev/null || echo 'Not available')"
echo ""
echo "========================================================"
echo ""

# ============================================================
# Function: Start VNC Server
# ============================================================
start_vnc() {
    echo "[VNC] Starting VNC server..."
    
    # Clean up old locks
    rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1 2>/dev/null || true
    
    # Create log directory
    mkdir -p /tmp
    
    # Start VNC with verbose logging
    echo "[VNC] Executing vncserver command..."
    vncserver :1 \
        -geometry ${VNC_RESOLUTION} \
        -depth ${VNC_COL_DEPTH} \
        -SecurityTypes None \
        -localhost no \
        --I-KNOW-THIS-IS-INSECURE \
        2>&1 | tee /tmp/vnc.log
    
    VNC_EXIT_CODE=${PIPESTATUS[0]}
    
    if [ $VNC_EXIT_CODE -ne 0 ]; then
        echo "[VNC] ✗ VNC server failed to start (exit code: $VNC_EXIT_CODE)"
        echo "[VNC] Log output:"
        cat /tmp/vnc.log
        echo "[VNC] Continuing without VNC..."
        return 1
    fi
    
    sleep 2
    
    # Check if VNC is actually running
    if pgrep -f Xtigervnc > /dev/null; then
        echo "[VNC] ✓ VNC server started on :1 (port ${VNC_PORT})"
        
        # Start noVNC web interface
        echo "[noVNC] Starting web interface..."
        websockify -D \
            --web=/opt/novnc/ \
            --heartbeat=30 \
            ${NOVNC_PORT} localhost:${VNC_PORT} \
            > /tmp/novnc.log 2>&1
        
        sleep 1
        echo "[noVNC] ✓ Web interface started on port ${NOVNC_PORT}"
    else
        echo "[VNC] ✗ VNC process not found after start attempt"
        echo "[VNC] Continuing without VNC..."
        return 1
    fi
}

# ============================================================
# Function: Start Jupyter
# ============================================================
start_jupyter() {
    echo "[Jupyter] Starting Jupyter Lab..."
    
    # Create log directory
    mkdir -p /tmp
    
    jupyter lab \
        --ip=0.0.0.0 \
        --port=${JUPYTER_PORT} \
        --no-browser \
        --notebook-dir=/workspace \
        --ServerApp.token='' \
        --ServerApp.password='' \
        --ServerApp.allow_origin='*' \
        > /tmp/jupyter.log 2>&1 &
    
    JUPYTER_PID=$!
    sleep 3
    
    # Check if Jupyter is running
    if ps -p $JUPYTER_PID > /dev/null; then
        echo "[Jupyter] ✓ Jupyter Lab started on port ${JUPYTER_PORT} (PID: $JUPYTER_PID)"
    else
        echo "[Jupyter] ✗ Jupyter Lab failed to start"
        echo "[Jupyter] Log output:"
        cat /tmp/jupyter.log
        return 1
    fi
}

# ============================================================
# Function: Display Access Information
# ============================================================
show_info() {
    echo ""
    echo "========================================================"
    echo "  ✅ Services Status"
    echo "========================================================"
    echo ""
    
    # Check Jupyter
    if pgrep -f jupyter > /dev/null; then
        echo "  📊 Jupyter Lab:        http://localhost:${JUPYTER_PORT} ✓"
    else
        echo "  📊 Jupyter Lab:        FAILED ✗"
    fi
    
    # Check VNC
    if pgrep -f Xtigervnc > /dev/null; then
        echo "  🖥️  VNC Web Interface:  http://localhost:${NOVNC_PORT}/vnc.html ✓"
        echo "  🔌 VNC Direct:         vnc://localhost:${VNC_PORT} ✓"
    else
        echo "  🖥️  VNC:                DISABLED (not critical)"
    fi
    
    echo ""
    echo "========================================================"
    echo "  Quick Commands"
    echo "========================================================"
    echo ""
    echo "  Octave CLI:"
    echo "    docker exec -it gammaspec-dev octave"
    echo ""
    echo "  Bash shell:"
    echo "    docker exec -it gammaspec-dev bash"
    echo ""
    echo "  View workspace:"
    echo "    docker exec -it gammaspec-dev tree -L 2 /workspace"
    echo ""
    echo "========================================================"
    echo ""
    echo "  Container is running. Press Ctrl+C to stop."
    echo ""
}

# ============================================================
# Function: Graceful Shutdown
# ============================================================
cleanup() {
    echo ""
    echo "🛑 Shutting down services..."
    
    if pgrep -f jupyter > /dev/null; then
        echo "  Stopping Jupyter..."
        pkill -f jupyter 2>/dev/null || true
    fi
    
    if pgrep -f websockify > /dev/null; then
        echo "  Stopping noVNC..."
        pkill -f websockify 2>/dev/null || true
    fi
    
    if pgrep -f Xtigervnc > /dev/null; then
        echo "  Stopping VNC server..."
        vncserver -kill :1 2>/dev/null || true
    fi
    
    echo "✓ Shutdown complete"
    exit 0
}

trap cleanup SIGTERM SIGINT

# ============================================================
# Main Execution
# ============================================================
case "$1" in
    full)
        echo "Starting all services..."
        echo ""
        
        # Start VNC (non-critical, continue if it fails)
        start_vnc || echo "[WARNING] VNC failed, continuing..."
        
        # Start Jupyter (critical)
        if ! start_jupyter; then
            echo "[ERROR] Jupyter failed to start. Exiting."
            exit 1
        fi
        
        show_info
        
        # Keep container alive
        if [ -f /tmp/jupyter.log ]; then
            tail -f /tmp/jupyter.log
        else
            tail -f /dev/null
        fi
        ;;
    
    vnc)
        echo "Starting VNC services only..."
        echo ""
        start_vnc || exit 1
        echo ""
        echo "✓ VNC Web: http://localhost:${NOVNC_PORT}/vnc.html"
        echo ""
        tail -f /tmp/vnc.log
        ;;
    
    jupyter)
        echo "Starting Jupyter only..."
        echo ""
        start_jupyter || exit 1
        echo ""
        echo "✓ Jupyter Lab: http://localhost:${JUPYTER_PORT}"
        echo ""
        tail -f /tmp/jupyter.log
        ;;
    
    octave)
        echo "Starting Octave CLI..."
        echo ""
        exec octave --no-gui
        ;;
    
    bash)
        echo "Starting interactive shell..."
        echo ""
        exec /bin/bash
        ;;
    
    test)
        echo "Running installation tests..."
        echo ""
        
        echo "Testing Octave:"
        octave --eval "disp('  ✓ Octave working')" 2>/dev/null || echo "  ✗ Octave failed"
        
        echo ""
        echo "Testing Python packages:"
        python3 -c "import numpy; print('  ✓ NumPy')" 2>/dev/null || echo "  ✗ NumPy"
        python3 -c "import scipy; print('  ✓ SciPy')" 2>/dev/null || echo "  ✗ SciPy"
        python3 -c "import matplotlib; print('  ✓ Matplotlib')" 2>/dev/null || echo "  ✗ Matplotlib"
        
        echo ""
        echo "Testing Jupyter:"
        python3 -c "import jupyterlab; print('  ✓ JupyterLab')" 2>/dev/null || echo "  ✗ JupyterLab"
        python3 -c "import octave_kernel; print('  ✓ Octave kernel')" 2>/dev/null || echo "  ✗ Octave kernel"
        
        echo ""
        echo "Testing utilities:"
        tree --version > /dev/null 2>&1 && echo "  ✓ tree" || echo "  ✗ tree"
        
        echo ""
        echo "════════════════════════════════════════════════════"
        echo "  Installation test complete!"
        echo "════════════════════════════════════════════════════"
        ;;
    
    *)
        echo "Usage: $0 {full|vnc|jupyter|octave|bash|test}"
        echo ""
        echo "  full     - Start all services (Jupyter + VNC) [default]"
        echo "  vnc      - Start VNC + noVNC only"
        echo "  jupyter  - Start Jupyter Lab only"
        echo "  octave   - Start Octave CLI"
        echo "  bash     - Interactive bash shell"
        echo "  test     - Run installation tests"
        echo ""
        exit 1
        ;;
esac