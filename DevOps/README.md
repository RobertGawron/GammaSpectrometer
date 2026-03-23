# Development Environment

## Overview

Docker image contains:
* Octave + Scientific packages
* Jupyter Notebook + Lab (with Octave kernel)
* VNC + noVNC web interface (to access Octave)
* Development tools (tree, git, vim, etc.)

## Prerequires

Docker installed on host machine.

### Build image

From project root:

```bash
docker-compose build
```

### Run the image

```bash
docker-compose build
```

### Usage

# Jupyter Notebook

From host machin access via web browser:

http://localhost:8888/

# Octave

From host machin access via web browser:

http://localhost:6080/vnc_lite.html

