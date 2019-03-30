#!/bin/bash
#
# 安装 Cygwin 到C盘或D盘
set -euo pipefail

readonly CYGLNK='/c/Users/Public/Desktop/Cygwin64 Terminal.lnk'
readonly CYGURL='https://mirrors.aliyun.com/cygwin/'
readonly CYGPAK='wget'

readonly drive="$1"
readonly rootdir="/${drive}/yzaj"
readonly srcdir="${rootdir}/cygwin/resource"
readonly destdir="${rootdir}/cygwin64"
readonly tempdir="${rootdir}/temp/cygwin"
readonly cygsrc="${srcdir}/Cygwin-x86_64.exe"
readonly cygwin="${destdir}/bin/mintty.exe"
baktime="$(date +'%Y-%m-%d-%H%M%S')"
readonly baktime

if [[ -f "${CYGLNK}" ]]; then
  rm "${CYGLNK}"
fi

if [[ -d "${destdir}" ]]; then
  mv "${destdir}" "${destdir}.bak.${baktime}"
fi

cd "${tempdir}"

"${cygsrc}" -q -W -R "${destdir}" -s "${CYGURL}" -P wget,curl


