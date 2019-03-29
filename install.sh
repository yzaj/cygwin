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
readonly repodir="/${drive}/yzaj/${REPO}"
readonly tempdir="/${drive}/yzaj/temp/${REPO}"
baktime="$(date +'%Y-%m-%d-%H%M%S')"
readonly baktime

if [[ -d "${repodir}" ]]; then
  mv "${repodir}" "${repodir}.bak.${baktime}"
fi

git clone --depth 1 "${url}" "${repodir}"

mkdir -p "${tempdir}/${REPO}"

if [[ -s "${repodir}/bin/cygwin.sh" ]]; then
  bash "${repodir}"/bin/cygwin.sh "${drive}" 2>&1 | tee "${phonelog}"
fi
