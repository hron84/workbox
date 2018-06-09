#!/bin/bash


HOST=$(hostname)
FQDN=$(hostname -f)

ME="$(readlink -f "$0")"
ANSIBLE_ROOT="$(dirname "${ME}")"

if [ -f /opt/ansible/hacking/setup ]; then
  source /opt/ansible/hacking/setup
fi

if [ -d "${ANSIBLE_ROOT}"/.git ]; then
  fgrep -q '[branch "master"]' "${ANSIBLE_ROOT}/.git/config" || git branch --set-upstream-to=origin/master master
  git pull --rebase
fi

if [ -f "${ANSIBLE_ROOT}/${HOST}.yml" ]; then
  PLAYBOOK="${ANSIBLE_ROOT}/${HOST}.yml"
elif [ -f "${ANSIBLE_ROOT}/${FQDN}.yml" ]; then
  PLAYBOOK="${ANSIBLE_ROOT}/${FQDN}.yml"
fi

if [ -z "${PLAYBOOK}" ]; then
  echo "$0: no playbook found for this host"
  exit 1
fi

if [ -z "${ANSIBLE_INVENTORY}" -a -f "${ANSIBLE_ROOT}/hosts" ]; then
  export ANSIBLE_INVENTORY="${ANSIBLE_ROOT}/hosts"
fi

if [ -z "${ANSIBLE_CONFIG}" -a -f "${ANSIBLE_ROOT}/ansible.cfg" ]; then
  export ANSIBLE_CONFIG="${ANSIBLE_ROOT}/ansible.cfg"
fi

if [ "$(id -u)" -ne 0 ]; then
  SUDO=sudo
fi

# Redirect everything from now
exec &>>/tmp/apull.log
set -xe

echo " -- Running Ansible at $(date +"%F %T") on ${FQDN} --"

# make sure ansible is up-to-date, even if we bootstraping the host right now
$SUDO ansible-playbook -i "${ANSIBLE_INVENTORY}" "${PLAYBOOK}" -t ansible
$SUDO ansible-playbook -i "${ANSIBLE_INVENTORY}" "${PLAYBOOK}" "$@"

echo " -- Ansible ended up at $(date +"%F %T") --"
