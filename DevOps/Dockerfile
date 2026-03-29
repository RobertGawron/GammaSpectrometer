# ============================================================
# Gamma Spectrometer + FPGA Development Environment Dockerfile
# ============================================================

FROM ubuntu:24.04

# Metadata
LABEL maintainer="robert@gammaspectrometer"
LABEL description="Unified Octave + Jupyter + VNC + FPGA environment"
LABEL version="2.5"
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
    HOME=/root \
    PATH="/opt/oss-cad-suite/bin:${PATH}"

# ============================================================
# Install Python 3.11 from deadsnakes PPA
# Required because vhdl-style-guide needs Python < 3.12
# ============================================================
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        software-properties-common \
        gpg-agent && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    add-apt-repository -y universe && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        python3.11 \
        python3.11-venv \
        python3.11-dev && \
    rm -rf /var/lib/apt/lists/*

# ============================================================
# Install System Dependencies
# ============================================================
RUN apt-get update && apt-get install -y --no-install-recommends \
    # ──────────────────────────────────────────────────────────
    # Core System Tools
    # ──────────────────────────────────────────────────────────
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
    build-essential \
    jq \
    less \
    # ──────────────────────────────────────────────────────────
    # OSS CAD Suite Runtime Libraries
    # ──────────────────────────────────────────────────────────
    libffi8 \
    libtcl8.6 \
    libreadline8 \
    # ──────────────────────────────────────────────────────────
    # Octave and Scientific Packages
    # ──────────────────────────────────────────────────────────
    octave \
    octave-dev \
    octave-control \
    octave-signal \
    octave-statistics \
    octave-image \
    octave-optim \
    octave-io \
    # ──────────────────────────────────────────────────────────
    # Plotting and Visualization
    # ──────────────────────────────────────────────────────────
    gnuplot \
    gnuplot-qt \
    ghostscript \
    texlive \
    texlive-latex-extra \
    # ──────────────────────────────────────────────────────────
    # VNC Server and Desktop Environment
    # ──────────────────────────────────────────────────────────
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
    # ──────────────────────────────────────────────────────────
    # Web Interface for VNC
    # ──────────────────────────────────────────────────────────
    websockify \
    # ──────────────────────────────────────────────────────────
    # Documentation Tools
    # ──────────────────────────────────────────────────────────
    doxygen \
    doxygen-latex \
    graphviz \
    # ──────────────────────────────────────────────────────────
    # FPGA Development & Waveform Viewer
    # ──────────────────────────────────────────────────────────
    gtkwave \
    # ──────────────────────────────────────────────────────────
    # Additional Utilities
    # ──────────────────────────────────────────────────────────
    htop \
    tmux \
    rsync \
    net-tools \
    procps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ============================================================
# Setup Python 3.11 Virtual Environment
# ============================================================
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN python3.11 -m venv $VIRTUAL_ENV && \
    pip install --no-cache-dir --upgrade pip

# ============================================================
# Verify Python Version
# ============================================================
RUN python --version && \
    echo "Python 3.11 virtual environment configured"

# ============================================================
# Configure Octave Directories (Fix SQL Database Warning)
# ============================================================
RUN mkdir -p /root/.cache/octave && \
    mkdir -p /root/.config/octave && \
    mkdir -p /root/.local/share/octave && \
    mkdir -p /root/.octave && \
    chmod -R 755 /root/.cache && \
    chmod -R 755 /root/.config && \
    chmod -R 755 /root/.local

# ============================================================
# Install OSS CAD Suite (FPGA Toolchain)
# ============================================================
RUN mkdir -p /opt && \
    wget -qO- https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2024-01-15/oss-cad-suite-linux-x64-20240115.tgz \
    | tar xz -C /opt/

# ============================================================
# Verify OSS CAD Suite Installation
# ============================================================
RUN echo "=== OSS CAD Suite Tool Versions ===" && \
    echo "--- GHDL (VHDL Compiler) ---" && \
    ghdl --version | head -3 && \
    echo "--- Yosys (Synthesis) ---" && \
    yosys -V && \
    echo "--- nextpnr-ice40 (Place & Route) ---" && \
    nextpnr-ice40 -V && \
    echo "--- icetime (Timing Analysis) ---" && \
    icetime 2>&1 | head -1 || true && \
    echo "--- icepack (Bitstream Generation) ---" && \
    which icepack && \
    echo "--- SymbiYosys (Formal Verification) ---" && \
    sby --help | head -3 && \
    echo "--- GHDL-Yosys Plugin ---" && \
    yosys -m ghdl -p "help ghdl"

# ============================================================
# Install noVNC (Web-based VNC Client)
# ============================================================
RUN git clone --depth 1 https://github.com/novnc/noVNC.git /opt/novnc && \
    ln -s /opt/novnc/vnc.html /opt/novnc/index.html

# ============================================================
# Install Additional Octave Packages via pkg
# ============================================================
RUN octave --no-gui --no-init-file --eval "\
    pkg install -forge symbolic; \
    pkg install -forge struct; \
    pkg install -forge io;"

# ============================================================
# Install Python Scientific Stack + Jupyter
# ============================================================
RUN pip install --no-cache-dir \
    # Scientific Computing
    numpy \
    scipy \
    matplotlib \
    pandas \
    sympy \
    # Jupyter Environment
    jupyterlab \
    notebook \
    jupyter_server \
    ipywidgets \
    octave_kernel \
    # Visualization
    plotly \
    seaborn \
    kaleido \
    # Data Handling
    h5py \
    openpyxl \
    # SPICE Simulation
    PyLTSpice \
    # FPGA/HDL Development Tools
    vhdl-style-guide \
    vunit_hdl \
    fusesoc \
    edalize \
    # Code Coverage & Reporting
    gcovr \
    junitparser

# ============================================================
# Configure Jupyter
# ============================================================
RUN mkdir -p /root/.jupyter
COPY DevOps/Configs/jupyter_server_config.py /root/.jupyter/jupyter_server_config.py

# Install Octave kernel for Jupyter
RUN python -m octave_kernel install

# ============================================================
# Configure VNC
# ============================================================
RUN mkdir -p /root/.vnc
COPY DevOps/Configs/xstartup /root/.vnc/xstartup
RUN chmod +x /root/.vnc/xstartup

# ============================================================
# Configure Octave
# ============================================================
COPY DevOps/Configs/.octaverc /root/.octaverc

# ============================================================
# Configure VHDL Style Guide (VSG)
# ============================================================
RUN mkdir -p /root/.config/vsg
COPY DevOps/Configs/.vsgrc /root/.config/vsg/config.yaml

# ============================================================
# Configure FuseSoC
# ============================================================
RUN mkdir -p /root/.config/fusesoc && \
    fusesoc library add fusesoc-cores https://github.com/fusesoc/fusesoc-cores || true

# ============================================================
# Verify FPGA Tool Installation
# ============================================================
RUN echo "=== FPGA Development Tools Verification ===" && \
    echo "--- Python Version ---" && \
    python --version && \
    echo "--- VSG (VHDL Style Guide) ---" && \
    vsg --version && \
    echo "--- VUnit ---" && \
    python -c "import vunit; print(f'VUnit {vunit.__version__}')" && \
    echo "--- FuseSoC ---" && \
    fusesoc --version && \
    echo "--- Doxygen ---" && \
    doxygen --version && \
    echo "--- GTKWave ---" && \
    gtkwave --version 2>&1 | head -1 || echo "GTKWave installed (requires display)"

# ============================================================
# Copy Entrypoint Script
# ============================================================
COPY DevOps/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# ============================================================
# Final Setup
# ============================================================
EXPOSE 5901 6080 8888

WORKDIR /workspace

HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD pgrep -f "jupyter|Xtigervnc" > /dev/null || exit 1

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["interactive"]