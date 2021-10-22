#!/usr/bin/env bash

set -eu

function buildDockerImage() {
    local dockerImageName="${1}"
    local dockerFilePath="${2}"
    local dockerTarget="${3}"

    if [ "${refresh}" == true ]; then
        local refreshArguments="--no-cache"
    else
        local refreshArguments=
    fi

    DOCKER_BUILDKIT=1 \
        docker \
            build \
                --file "${dockerFilePath}" \
                --tag="${dockerImageName}" \
                --target="${dockerTarget}" \
                --build-arg DOCKER_UID="$(id -u)" \
                --build-arg DOCKER_GID="$(id -g)" \
                ${refreshArguments} \
                "${PROJECT_DIR}"
}

refresh=false
for param in "${@}"; do
    if [ "${param}" == "--refresh" ]; then
        refresh=true
    fi
done

buildDockerImage "${DOCKER_IMAGE}" "${DOCKER_FILE_PATH}" "${DOCKER_TARGET}"
