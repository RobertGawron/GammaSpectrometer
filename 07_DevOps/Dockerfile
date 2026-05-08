# ============================================================
# Gamma Spectrometer Development Environment
# ============================================================
FROM ubuntu:24.04

# Metadata
LABEL maintainer="robert@gammaspectrometer"
LABEL description="Unified Octave + Jupyter + VNC + FPGA environment"
LABEL version="2.6"
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
    build-essential \
    jq \
    less \
    software-properties-common \
    # OSS CAD Suite Runtime Libraries
    libffi8 \
    libtcl8.6 \
    libreadline8 \
    # Octave and Scientific Packages
    octave \
    octave-dev \
    octave-control \
    octave-signal \
    octave-statistics \
    octave-image \
    octave-optim \
    octave-io \
    # Plotting and Visualization + Full LaTeX Math Support
    gnuplot \
    gnuplot-qt \
    ghostscript \
    texlive \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-science \
    texlive-pictures \
    texlive-plain-generic \
    latexmk \
    dvipng \
    cm-super \
    fontconfig \
    fonts-freefont-otf \
    fonts-dejavu-core \
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
    # Documentation Tools
    doxygen \
    doxygen-latex \
    graphviz \
    # FPGA Development & Waveform Viewer
    gtkwave \
    # Additional Utilities
    htop \
    tmux \
    rsync \
    net-tools \
    procps \
    just \
    # Python
    python3 \
    python3-venv \
    python3-dev \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ============================================================
# Setup Python Virtual Environment
# ============================================================
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN python3 -m venv $VIRTUAL_ENV && \
    pip install --no-cache-dir --upgrade pip setuptools wheel

# ============================================================
# Configure Octave Directories
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

# Verify OSS CAD Suite Installation
RUN echo "=== OSS CAD Suite Tool Versions ===" && \
    ghdl --version | head -3 && \
    yosys -V && \
    nextpnr-ice40 -V && \
    which icepack && \
    sby --help | head -3

# ============================================================
# Install noVNC
# ============================================================
RUN git clone --depth 1 https://github.com/novnc/noVNC.git /opt/novnc && \
    ln -s /opt/novnc/vnc.html /opt/novnc/index.html

# ============================================================
# Install Additional Octave Packages
# ============================================================
RUN octave --no-gui --no-init-file --eval "\
    pkg install -forge symbolic; \
    pkg install -forge struct; \
    pkg install -forge io;"

# ============================================================
# Install Python Packages
# ============================================================
# ============================================================
# Install Python Packages
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
    # Jupyter Code Quality (notebook adapter)
    nbqa \
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
    vunit_hdl \
    fusesoc \
    edalize \
    # Code Coverage & Quality Analysis
    gcovr \
    junitparser \
    ruff \
    mypy \
    radon \
    # Security
    pip-audit \
    # Code Formatting
    black \
    # Development Workflow
    pre-commit \
    # Utilities
    cheat \
    # LaTeX Support in Jupyter
    jupyterlab-latex \
    pylatexenc

# ============================================================
# Install VSG from GitHub (latest version supports Python 3.12)
# ============================================================
RUN pip install --no-cache-dir \
    git+https://github.com/jeremiah-c-leary/vhdl-style-guide.git

# Verify VSG
RUN vsg --version

# ============================================================
# Configure Jupyter
# ============================================================
RUN mkdir -p /root/.jupyter
COPY 07_DevOps/Configs/jupyter_server_config.py /root/.jupyter/jupyter_server_config.py
RUN python -m octave_kernel install

# ============================================================
# Configure VNC
# ============================================================
RUN mkdir -p /root/.vnc
COPY 07_DevOps/Configs/xstartup /root/.vnc/xstartup
RUN chmod +x /root/.vnc/xstartup

# ============================================================
# Configure Octave
# ============================================================
COPY 07_DevOps/Configs/.octaverc /root/.octaverc

# ============================================================
# Configure FuseSoC
# ============================================================
RUN mkdir -p /root/.config/fusesoc && \
    fusesoc library add fusesoc-cores https://github.com/fusesoc/fusesoc-cores || true

# ============================================================
# Verify All Tools
# ============================================================
RUN echo "=== Final Verification ===" && \
    echo "Python: $(python --version)" && \
    echo "VSG: $(vsg --version)" && \
    python -c "import vunit; print(f'VUnit: {vunit.__version__}')" && \
    echo "FuseSoC: $(fusesoc --version)" && \
    echo "Doxygen: $(doxygen --version)" && \
    echo "All tools verified!"

# ============================================================
# Copy Entrypoint Script
# ============================================================
COPY 07_DevOps/entrypoint.sh /usr/local/bin/entrypoint.sh
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
