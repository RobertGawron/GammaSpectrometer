#!/bin/bash
set -e

start_vnc() {
    rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1 2>/dev/null || true
    vncserver :1 \
        -geometry ${VNC_RESOLUTION:-1920x1080} \
        -depth ${VNC_COL_DEPTH:-24} \
        -SecurityTypes None \
        -localhost no \
        --I-KNOW-THIS-IS-INSECURE > /dev/null 2>&1
    
    websockify -D \
        --web=/opt/novnc/ \
        --heartbeat=30 \
        ${NOVNC_PORT:-6080} localhost:${VNC_PORT:-5901} > /dev/null 2>&1
}

start_jupyter() {
    jupyter lab \
        --ip=0.0.0.0 \
        --port=${JUPYTER_PORT:-8888} \
        --no-browser \
        --notebook-dir=/workspace \
        --ServerApp.token='' \
        --ServerApp.password='' \
        --ServerApp.allow_origin='*' > /dev/null 2>&1 &
}

case "${1:-bash}" in
    interactive|full)
        start_vnc
        start_jupyter
        echo "VNC:     http://localhost:${NOVNC_PORT:-6080}/vnc.html"
        echo "Jupyter: http://localhost:${JUPYTER_PORT:-8888}"
        if [ "$1" = "interactive" ]; then
            exec /bin/bash
        else
            tail -f /dev/null
        fi
        ;;
    
    sleep)
        # CI mode - just keep container alive
        exec sleep infinity
        ;;
    
    *)
        # Run any command passed
        exec "$@"
        ;;
esac