#!/bin/bash
# Substitui as variaveis de ambiente nos arquivos de configurração do wildfly
set -e

VARIABLES=(
	POOL_NAME
  URL
)

set_config() {
	key="ENV_VAR_$1"
	value="$2"
	find /augeas-conf/ -type f -name "*.*" | xargs sed -i 's/'"$key"'/'"$value"'/g'
}

for var in "${VARIABLES[@]}"; do
	eval var_value=\$$var
	if [ -z "$var_value" ]; then
		echo >&2
		echo >&2 '=================================================================================================='
		echo >&2
 		echo >&2 'Erro: Variavel de ambiente '$var' não foi setada.'
 		echo >&2
 		echo >&2 '=================================================================================================='
 		echo >&2
 		exit 1
 	else
 		set_config "$var" "$var_value"
 	fi
done

for filename in /augeas-conf/*.cmd; do
    augtool -LA -e -f $filename
done

exec "$@"
