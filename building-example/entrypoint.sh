#!/bin/bash

# Script entrypoint, executado antes da execução do serviço.
# Utilizado para ajustes de configuração do ambiente para execução do serviço.


# Variaveis
VARIABLES=(
	VALUE_TEST
  PARAM_TEST
)

# Função se substituicao chave --> valor
set_config() {
	key="$1"
	value="$2"
	find /data -type f -name "*.xml" | xargs sed -i 's/'"$key"'/'"$value"'/g'
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

# Executa o CMD apos a execução do entrypoint
exec "$@"
