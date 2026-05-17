# Playground for Mitsuba3 Custom Builds

A Docker + UV setup for building Mitsuba3 from source, using it in scripts
or Marimo notebooks, and optionally contributing changes back upstream.

## How to use

### Manage the Docker container

> **NOTE:** the Docker files are designed to run on *rootless* mode.

The commands below are intended to be run from the host shell in the ./docker directory of the project.

The container build clones Mitsuba3 as a submodule. By default, it clones from
the official Mitsuba3 repo and uses the "stable" branch. To clone from your own fork, pass the GITHUB_USER argument; to use a particular branch or tag, pass
the MITSUBA_REF argument.


| Description | Command |
|-------------|---------|
| Build the container | `docker compose build --build-arg GITHUB_USER=<your_user> --build-arg MITSUBA_REF=<ref_to_clone>` |
| Re-build the container | `docker compose build --no-cache --build-arg GITHUB_USER=<your_user> --build-arg MITSUBA_REF=<ref_to_clone>` |
| Start the container | `docker compose up -d` |
| Stop the container | `docker compose down` |
| Open a shell in the container | `docker compose exec mitsuba3_playground bash` |
| Run a command in the container (from the host shell) | `docker compose exec mitsuba3_playground <command>` |

### Create the Python environment and install dependencies

This project uses [UV](https://github.com/astral-sh/uv) to manage Python virtual environments and dependencies.

To create the Python environment and install all dependencies from [pyproject.toml](pyproject.toml), use:

```sh
docker compose exec mitsuba3_playground uv sync
```

To add dependencies, use:

```sh
docker compose exec mitsuba3_playground uv add <python_package>
```


## TODO

[ ] Support GPU or CPU in Dockerfile and compose.yaml.
[ ] Test in Windows/MacOS.