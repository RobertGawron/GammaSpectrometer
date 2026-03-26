# ============================================================
# Gamma Spectrometer + FPGA Development Environment Dockerfile
# 
# Includes:
#   - Octave + Scientific packages
#   - Jupyter Notebook + Lab
#   - VNC + noVNC web interface
#   - OSS CAD Suite (GHDL, Yosys, nextpnr-ice40)
#   - Development tools (tree, git, etc.)
# ============================================================

FROM ubuntu:22.04

# Metadata
LABEL maintainer="robert@gammaspectrometer"
LABEL description="Unified Octave + Jupyter + VNC + FPGA environment"
LABEL version="2.1"
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
    LC_ALL=C.UTF-8 \
    PATH="/opt/oss-cad-suite/bin:${PATH}"

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
    jq \
    less \
    # OSS CAD Suite Runtime Libraries
    libffi8 \
    libtcl8.6 \
    libreadline8 \
    # Octave and Scientific Packages
    octave \
    octave-control \
    octave-signal \
    octave-statistics \
    octave-image \
    octave-optim \
    octave-io \
    liboctave-dev \
    # Plotting and Visualization (CHOOSE ONE gnuplot backend!)
    gnuplot \
    gnuplot-qt \
    ghostscript \
    texlive \
    texlive-latex-extra \
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
    gtkwave \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ============================================================
# Install OSS CAD Suite (FPGA Toolchain)
# ============================================================
RUN mkdir -p /opt && \
    wget -qO- https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2024-01-15/oss-cad-suite-linux-x64-20240115.tgz \
    | tar xz -C /opt/

# Verify OSS CAD Suite installation
RUN echo "=== Tool Versions ===" && \
    ghdl --version && \
    yosys -V && \
    nextpnr-ice40 -V && \
    echo "=== GHDL Plugin Check ===" && \
    yosys -m ghdl -p "help ghdl"

# ============================================================
# Install noVNC (newer version from GitHub)
# ============================================================
RUN git clone --depth 1 https://github.com/novnc/noVNC.git /opt/novnc && \
    ln -s /opt/novnc/vnc.html /opt/novnc/index.html

# ============================================================
# Install Additional Octave Packages via pkg
# ============================================================
RUN octave --no-gui --eval "pkg install -forge symbolic" && \
    octave --no-gui --eval "pkg install -forge struct" && \
    octave --no-gui --eval "pkg install -forge io"

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
    openpyxl \
    ltspice \
    PyLTSpice \
    kaleido

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

COPY DevOps/octaverc /home/developer/.octaverc
RUN chown developer:developer /home/developer/.octaverc

COPY DevOps/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh && \
    chown developer:developer /usr/local/bin/entrypoint.sh

# ============================================================
# Final Setup
# ============================================================
EXPOSE 5901 6080 8888

WORKDIR /workspace

HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD pgrep -f "jupyter|Xtigervnc" > /dev/null || exit 1

USER developer

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["interactive"]