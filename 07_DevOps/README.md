# Development Environment

## Overview

Docker image contains:
* Octave + Scientific packages
* Jupyter Notebook + Lab (with Octave kernel)
* VNC + noVNC web interface (to access Octave)
* Development tools (tree, git, vim, etc.)

## Prerequires

Docker installed on host machine.

## Configure Git

Don't use Windows line endings:

```bash
git config --global core.autocrlf input
```

### Build image

From project root:

```bash
docker-compose build
```

### Run the image

```bash
cd Devops && docker-compose run --rm --service-ports gammaspec-dev
```

### Usage

# Jupyter Notebook

From host machine access via web browser:

http://localhost:8888/

# Octave

From host machine access via web browser:

http://localhost:6080/vnc_lite.html


