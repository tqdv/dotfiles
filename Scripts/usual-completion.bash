#/usr/bin/env bash

_usual_completions () {
	if [ "${#COMP_WORDS[@]}" != "2" ]; then
		return
	fi

	COMPREPLY=($(compgen -W "create attach kill vpn edit" "${COMP_WORDS[1]}"))
}

complete -F _usual_completions usual
