#!/usr/bin/env bash

set -eu

readonly DOCKER_FILE_PATH="${PROJECT_DIR}"/docker/php/Dockerfile
readonly DOCKER_IMAGE_DEV="sully-resume/php:dev"
