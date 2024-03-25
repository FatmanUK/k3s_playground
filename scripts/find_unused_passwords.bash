#!/bin/bash
set -euxo pipefail

PWS=$(ansible-vault view vaults/dev-vault.yml --vault-password-file vaults/dev-password.txt | awk -F: '/password/ {print $1}')

for PW in ${PWS}; do
	C=$(ag ${PW} | wc -l)
	if [ ${C} -eq 0 ] ; then
		echo ${PW}
	fi
done
