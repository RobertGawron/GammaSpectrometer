# Gamma Spectrometer Development Environment

## Overview

**Single unified Docker image** containing:
- ✅ Octave + Scientific packages
- ✅ Jupyter Notebook + Lab (with Octave kernel)
- ✅ VNC + noVNC web interface
- ✅ Development tools (tree, git, vim, etc.)

## Quick Start

### Build and Start

```bash
# From project root
cd ~/Documents/GammaSpectrometer

# Build and start
docker-compose up -d --build

# View logs
docker-compose logs -f gammaspec-dev

# Check status
docker-compose ps

http://localhost:6080/vnc_lite.html

http://localhost:8888/lab/tree/docker-compose.yml