# Playground for Mitsuba3 Custom Builds

A Docker setup for building [Mitsuba3](https://github.com/mitsuba-renderer/mitsuba3) from source, using it in scripts or notebooks, and optionally contributing changes back upstream.

## Features

- Build Mitsuba from source easily
- Manage python environment with [UV](https://docs.astral.sh/uv/)
- Sample [Marimo](https://marimo.io/) notebooks

## System Prerequisites

- Docker (the Docker files have been tested to work in *rootless* mode)
- Docker Compose
- git

For using the GPU for CUDA variants you also need the [Nvidia container toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html).

## Quick Start

Run the docker commands below from the `docker` directory of the repo.

1. Build and launch the container:

   ```shell
   docker compose up --build
   ```

   After this, press "d" to detach, the container will keep running.

1. The provided script clones Mitsuba3 as a submodule in the right location. By default, it clones from the official Mitsuba3 repo and uses the "stable" branch. To change this, set the **GITHUB_USER** and **MITSUBA_REF** environment variables in the `docker/.env` file.

1. Clone Mitsuba:

   ```shell
   docker compose exec mitsuba3_playground bash /workspace/mitsuba3_build_utils/clone_mitsuba.sh
   ```

1. Build Mitsuba. This will also create the UV Python environment if needed and install Mitsuba Python package:

   ```shell
   docker compose exec mitsuba3_playground bash /workspace/mitsuba3_build_utils/build_mitsuba.sh
   ```

1. You can check the build with the sample Marimo notebooks, navigate to `http://localhost:2719`. Replace `localhost` by the right IP if running on a server.

## Other Docker Commands

| Description | Command |
|-------------|---------|
| Build the container | `docker compose build` |
| Re-build the container | `docker compose build --no-cache` |
| Start the container | `docker compose up -d` |
| Stop the container | `docker compose down` |
| Open a shell in the container | `docker compose exec mitsuba3_playground bash` |
| Run a command in the container from the host shell | `docker compose exec mitsuba3_playground <command>` |

## Python Environment and Additional Dependencies

This project uses [UV](https://docs.astral.sh/uv/reference/cli/) to manage a Python virtual environment and dependencies.

To add or remove dependencies, use:

```shell
docker compose exec mitsuba3_playground uv add <python_package>
```

```shell
docker compose exec mitsuba3_playground uv remove <python_package>
```

The environment is created automatically. If you need to recreate it and install all the dependencies from [pyproject.toml](./pyproject.toml), delete the `./venv` directory, and run:

```shell
docker compose exec mitsuba3_playground uv sync
```

## Mitsuba Build and Variants

The [mitsuba building script](./mitsuba3_build_utils/build_mitsuba.sh) uses the config file located at [./mitsuba3_build_utils/custom_mitsuba.conf](./mitsuba3_build_utils/custom_mitsuba.conf). If needed, in particular to define new variants, use this file and not the `mitsuba.conf` file in the build directory, as this gets overwritten at each build.

Search for this part of the file:

```yaml
    # HERE: include which variants to build.
    "enabled": [
        "scalar_rgb",
        "scalar_spectral",
        "cuda_ad_rgb"
        ...
    ],

```

You must include at least the `scalar_rgb` and one `xxx_ad_xxx` variants, otherwise you'll get building errors. Remember that the more variants you build, the longer the build will take.

Also, the builds are cached with [ccache](https://ccache.dev/).

## Marimo Notebooks

The Marimo server is launched at container startup, if required, it can be stopped with:

```shell
docker compose exec mitsuba3_playground pkill -f "marimo edit"
```

And relaunched with:

```shell
docker compose exec mitsuba3_playground uv run marimo edit /workspace/notebooks --host 0.0.0.0 --port 2719 --no-token &
```
