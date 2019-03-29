#!/bin/bash
#
# 安装 Cygwin 到C盘或D盘
set -euo pipefail

readonly REPO='cygwin'
readonly url="https://github.com/yzaj/${REPO}.git"
drive='c'

if [[ -d "/d" ]]; then
  drive='d'
fi

readonly drive
readonly ownerdir="/${drive}/yzaj"
readonly repodir="/${drive}/yzaj/${REPO}"

git clone --depth 1 "${url}" "${repodir}"
