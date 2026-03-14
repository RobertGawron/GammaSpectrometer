# ============================================================
# Gamma Spectrometer Development Environment Dockerfile
# 
# Includes:
#   - Octave + Scientific packages
#   - Jupyter Notebook + Lab
#   - VNC + noVNC web interface
#   - Development tools (tree, git, etc.)
# ============================================================

FROM ubuntu:22.04

# Metadata
LABEL maintainer="robert@gammaspectrometer"
LABEL description="Unified Octave + Jupyter + VNC development environment"
LABEL version="2.0"
LABEL project="GammaSpectrometer"

# ============================================================
# Environment Variables
# ============================================================
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=UTC \
    DISPLAY=:1 \
    VNC_PORT=5901 \
    NOVNC_PORT=6080 \
    JUPYTER_PORT=8888 \
    VNC_RESOLUTION=1920x1080 \
    VNC_COL_DEPTH=24 \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# ============================================================
# Create Application User
# ============================================================
RUN useradd -m -s /bin/bash -u 1000 developer && \
    mkdir -p /workspace && \
    chown -R developer:developer /workspace

# ============================================================
# Install System Dependencies
# ============================================================
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Core System Tools
    wget \
    curl \
    git \
    tree \
    vim \
    nano \
    unzip \
    zip \
    ca-certificates \
    gnupg \
    software-properties-common \
    build-essential \
    # Octave and Scientific Packages
    octave \
    octave-control \
    octave-signal \
    octave-statistics \
    octave-image \
    octave-optim \
    octave-io \
    liboctave-dev \
    # Plotting and Visualization
    gnuplot \
    gnuplot-x11 \
    ghostscript \
    # VNC Server and Desktop Environment
    tigervnc-standalone-server \
    tigervnc-common \
    xfce4 \
    xfce4-terminal \
    xfce4-goodies \
    dbus-x11 \
    xfonts-base \
    xfonts-100dpi \
    xfonts-75dpi \
    xfonts-scalable \
    # Web Interface for VNC
    websockify \
    # Python Stack
    python3 \
    python3-pip \
    python3-dev \
    python3-setuptools \
    python3-wheel \
    # Additional Utilities
    htop \
    tmux \
    rsync \
    net-tools \
    procps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ============================================================
# Install noVNC (newer version from GitHub)
# ============================================================
RUN git clone --depth 1 https://github.com/novnc/noVNC.git /opt/novnc && \
    ln -s /opt/novnc/vnc.html /opt/novnc/index.html

# ============================================================
# Install Additional Octave Packages via pkg
# ============================================================
RUN octave --eval "pkg install -forge symbolic" || true && \
    octave --eval "pkg install -forge struct" || true && \
    octave --eval "pkg install -forge parallel" || true

# ============================================================
# Install Python Scientific Stack + Jupyter
# ============================================================
RUN pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir \
    numpy \
    scipy \
    matplotlib \
    pandas \
    sympy \
    jupyterlab \
    "notebook<7" \
    jupyter_server \
    ipywidgets \
    octave_kernel \
    plotly \
    seaborn \
    h5py \
    openpyxl

# ============================================================
# Configure Jupyter
# ============================================================
USER developer
WORKDIR /home/developer

RUN mkdir -p /home/developer/.jupyter && \
    echo "c.ServerApp.ip = '0.0.0.0'" > /home/developer/.jupyter/jupyter_server_config.py && \
    echo "c.ServerApp.open_browser = False" >> /home/developer/.jupyter/jupyter_server_config.py && \
    echo "c.ServerApp.port = 8888" >> /home/developer/.jupyter/jupyter_server_config.py && \
    echo "c.ServerApp.token = ''" >> /home/developer/.jupyter/jupyter_server_config.py && \
    echo "c.ServerApp.password = ''" >> /home/developer/.jupyter/jupyter_server_config.py && \
    echo "c.ServerApp.root_dir = '/workspace'" >> /home/developer/.jupyter/jupyter_server_config.py && \
    echo "c.ServerApp.allow_origin = '*'" >> /home/developer/.jupyter/jupyter_server_config.py && \
    echo "c.ServerApp.disable_check_xsrf = True" >> /home/developer/.jupyter/jupyter_server_config.py

# Install Octave kernel for Jupyter
RUN python3 -m octave_kernel install --user

# ============================================================
# Configure VNC
# ============================================================
RUN mkdir -p /home/developer/.vnc && \
    echo '#!/bin/sh' > /home/developer/.vnc/xstartup && \
    echo 'unset SESSION_MANAGER' >> /home/developer/.vnc/xstartup && \
    echo 'unset DBUS_SESSION_BUS_ADDRESS' >> /home/developer/.vnc/xstartup && \
    echo 'exec startxfce4' >> /home/developer/.vnc/xstartup && \
    chmod +x /home/developer/.vnc/xstartup

# ============================================================
# Copy Configuration Files
# ============================================================
USER root

COPY octaverc /home/developer/.octaverc
RUN chown developer:developer /home/developer/.octaverc

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh && \
    chown developer:developer /usr/local/bin/entrypoint.sh

# ============================================================
# Final Setup
# ============================================================
EXPOSE 5901 6080 8888

WORKDIR /workspace

HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD pgrep -f "jupyter|Xtigervnc" > /dev/null || exit 1

VOLUME ["/workspace"]

USER developer

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["full"]