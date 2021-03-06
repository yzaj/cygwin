#!/bin/bash
#
# 安装 Cygwin 到C盘或D盘
set -euo pipefail

readonly CYGLNK='/c/Users/Public/Desktop/Cygwin64 Terminal.lnk'
readonly CYGURL='https://mirrors.aliyun.com/cygwin/'
readonly CYGPAK='wget,curl,screen,tree,git,patch,psmisc,rsync,cron,vim'
readonly E_INSTALL_FAILED=1

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

readonly oneself="$0"
readonly drive="$1"
readonly rootdir="/${drive}/yzaj"
readonly srcdir="${rootdir}/cygwin/resource"
readonly destdir="${rootdir}/cygwin64"
readonly tempdir="${rootdir}/temp/cygwin"
readonly bakdir="${rootdir}/backup/cygwin64"
readonly cygsrc="${srcdir}/Cygwin-x86_64.exe"
readonly cygwin="${destdir}/bin/mintty.exe"
baktime="$(date +'%Y-%m-%d-%H%M%S')"
username="$(whoami)"
readonly baktime
readonly username
readonly userdir="${destdir}/home/${username}"

# 安装 Cygwin
mkdir -p "${bakdir}"

if [[ -f "${CYGLNK}" ]]; then
  rm "${CYGLNK}"
fi

if [[ -d "${destdir}" ]]; then
  mv "${destdir}" "${bakdir}/cygwin64.bak.${baktime}"
fi

cd "${tempdir}"

"${cygsrc}" -q -W -R "${destdir}" -s "${CYGURL}" -P "${CYGPAK}"

if [[ ! -f "${cygwin}" ]]; then
  err "${oneself##*/}: cygwin install failed"
  exit "${E_INSTALL_FAILED}"
fi

# 复制文件
mkdir -p "${userdir}"
cp "${srcdir}"/apt-cyg "${destdir}"/bin
cp "${srcdir}"/{'.bashrc','.bash_profile','.inputrc','.profile','.minttyrc'} "${userdir}"

# 运行 Cygwin
"${cygwin}" -i "${destdir}"/Cygwin-Terminal.ico -e "${destdir}"/bin/bash --login -i -c "ln -s /cygdrive/${drive}/yzaj /yzaj"
