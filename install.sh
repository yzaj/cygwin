#!/bin/bash
#
# 安装 Cygwin 到C盘或D盘
set -euo pipefail

readonly REPO='cygwin'

drive='c'
if [[ -d "/d" ]]; then
  drive='d'
fi

readonly drive
readonly url="https://github.com/yzaj/${REPO}.git"
readonly repodir="/${drive}/yzaj/${REPO}"
readonly tempdir="/${drive}/yzaj/temp/${REPO}"
readonly bakdir="/${drive}/yzaj/backup/${REPO}"
baktime="$(date +'%Y-%m-%d-%H%M%S')"
readonly baktime

mkdir -p "${tempdir}"
mkdir -p "${bakdir}"






if [[ -d "${repodir}" ]]; then
  mv "${repodir}" "${repodir}.bak.${baktime}"
fi

git clone --depth 1 "${url}" "${repodir}"



if [[ -s "${repodir}/bin/${REPO}.sh" ]]; then
  bash "${repodir}"/bin/"${REPO}.sh" "${drive}" 2>&1 | tee "${tempdir}/${REPO}.log"
fi
