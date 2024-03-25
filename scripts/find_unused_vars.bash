#!/bin/bash
set -uxo pipefail

# pipe 2>/dev/null to silence debug output

# Get role and group vars
VARS=$(ag -a '^[a-z0-9_-]*?:' group_vars roles/*/defaults roles/*/vars --nonumbers | awk '/:/ {print $1}' | cut -d: -f2 | sort -u)

for VAR in ${VARS}; do
	REFS=$(ag ${VAR} --stats-only | head -1 | cut -d\  -f1)
	if [ $(( ${REFS} + 0 )) -gt 1 ]; then
		continue
	fi
	echo "Var ${VAR} is never referenced"
done

# Get inventory vars
VARS=$(ag -a '^[^#]   *[a-z0-9_-]*?: ' site/ --nonumbers | cut -d: -f2 | sort -u)

for VAR in ${VARS}; do
	REFS=$(ag ${VAR} --stats-only | head -1 | cut -d\  -f1)
	if [ $(( ${REFS} + 0 )) -gt 1 ]; then
		continue
	fi
	echo "Var ${VAR} is never referenced"
done
