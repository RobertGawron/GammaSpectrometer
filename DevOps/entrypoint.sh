#!/bin/bash
set -e

# ============================================================
# Background Service Functions
# ============================================================
start_vnc() {
    rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1 2>/dev/null || true
    mkdir -p /tmp
    
    # Start VNC silently
    vncserver :1 \
        -geometry ${VNC_RESOLUTION} \
        -depth ${VNC_COL_DEPTH} \
        -SecurityTypes None \
        -localhost no \
        --I-KNOW-THIS-IS-INSECURE > /dev/null 2>&1
    
    # Start noVNC silently
    websockify -D \
        --web=/opt/novnc/ \
        --heartbeat=30 \
        ${NOVNC_PORT} localhost:${VNC_PORT} > /dev/null 2>&1
}

start_jupyter() {
    mkdir -p /tmp
    jupyter lab \
        --ip=0.0.0.0 \
        --port=${JUPYTER_PORT} \
        --no-browser \
        --notebook-dir=/workspace \
        --ServerApp.token='' \
        --ServerApp.password='' \
        --ServerApp.allow_origin='*' > /dev/null 2>&1 &
}

show_status() {
    echo "--- Services ---"
    pgrep -f Xtigervnc > /dev/null && echo "VNC:     http://localhost:${NOVNC_PORT}/vnc.html" || echo "VNC:     OFF"
    pgrep -f jupyter > /dev/null && echo "Jupyter: http://localhost:${JUPYTER_PORT}" || echo "Jupyter: OFF"
    echo "----------------"
}

# ============================================================
# Main Execution Logic
# ============================================================
case "$1" in
    interactive)
        start_vnc
        start_jupyter
        show_status
        exec /bin/bash
        ;;

    full)
        start_vnc
        start_jupyter
        show_status
        echo "Running in daemon mode. Press Ctrl+C to stop."
        tail -f /dev/null
        ;;
    
    bash)
        exec /bin/bash
        ;;
    
    *)
        echo "Usage: $0 {interactive|full|bash}"
        exit 1
        ;;
esac