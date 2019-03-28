#!/bin/bash
#
# 任意仓库的安装脚本
set -euxo pipefail

# 修改 REPO 的值, 即可
readonly DOMAIN='github.com'
readonly OWNER='yzaj'
readonly REPO='phone'
readonly CMD='git'

readonly url="https://${DOMAIN}/${OWNER}/${REPO}.git"
readonly repodir="/${OWNER}/${REPO}"
readonly src="/etc/profile.d/${OWNER}-${REPO}.sh"

if [[ "${REPO}" == "yzaj" || "${REPO}" == "log" ]]; then
  exit 1
fi

if ! type "${CMD}"; then
  apt-cyg install "${CMD}"
fi

git clone --depth 1 "${url}" "${repodir}"

if [[ -d "${repodir}/bin" ]]; then
  chmod -R 755 "${repodir}"/bin/
  echo "export PATH=\${PATH}:${repodir}/bin" > "${src}"
fi

mkdir -p "/${OWNER}"/log/"${REPO}"
