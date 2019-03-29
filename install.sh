#!/bin/bash
#
# 安装 Cygwin 到C盘或D盘
set -euo pipefail

readonly REPO='cygwin'
readonly url="https://github.com/yzaj/${REPO}.git"
drive='c'

readonly drive
readonly repodir="/${drive}/yzaj/${REPO}"

git clone --depth 1 "${url}" "${repodir}"
