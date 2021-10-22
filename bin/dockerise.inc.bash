#!/usr/bin/env bash

set -eu

if type docker > /dev/null 2>&1; then
    readonly isInDocker=false
else
    readonly isInDocker=true
fi

if [ -z "${BIN_DIR-}" ]; then
    BIN_DIR="bin"
fi

if [ -z "${DOCKER_IMAGE}" ]; then
    echo "You should declare var DOCKER_IMAGE"
    exit 1
fi

if ! ${isInDocker}; then
    set +e
    tty -s && isInteractiveShell=true || isInteractiveShell=false
    set -e

    if ${isInteractiveShell}; then
        interactiveParameter="--interactive"
    else
        interactiveParameter=
    fi

    docker \
        run \
            --rm \
            --tty \
            ${interactiveParameter} \
            --volume "${PROJECT_DIR}":/app \
            --user "$(id -u)":"$(id -g)" \
            --entrypoint "${BIN_DIR}"/"$(basename "${0}")" \
            --workdir /app \
            --env HOST_ROOT_DIR="${PROJECT_DIR}" \
            "${DOCKER_IMAGE}" \
            "${@}"
    exit 0
fi
