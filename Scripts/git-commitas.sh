#!/bin/sh

# Use shellcheck to lint

USAGE="$(cat << END
Usage: git commitas <as-user> <arguments>
       git commitas [ --help | -h ]
       git commitas [ --man ]
END
)"

MAN="$(cat << END
$USAGE

This script overrides the GIT_AUTHOR_* and GIT_COMMITTER_* environment variables
with git config values users.<as-user>.name and users.<as-user>.email.

For a user named John, you would add this to your git config:
\`\`\`
[users "John"]
    name = "John Doe"
    email = "john.doe@example.com"
\`\`\`
And call it as so: git commitas John <arguments>

Note that <as-user> is case-sensitive and can not start with a hyphen.

Dependencies: sh, [cat, cut, tr, env](probably POSIX), git

Licensed by Tilwa Qendov under The Artistic 2.0 license
END
)"


# Check arguments
useras=$1
shift

if [ -z "$useras" ]
then
	echo "Error: missing user name" >&2
	echo "$USAGE" >&2
	exit 1
fi

# Handle help, manual and unknown flags
if [ "$useras" = '--help' ] || [ "$useras" = '-h' ]
then
	echo "$USAGE"
	exit 0
elif [ "$useras" = '--man' ]
then
	echo "$MAN"
	exit 0
elif [ "$(echo "$useras" | cut -c1)" = '-' ] # First character is '-'
then
	echo "Error: unknown flag '$useras'" >&2
	exit 1
fi

# Filter invalid characters
# NB: command line can't contain the null byte anyways
invalid="$(echo "$useras" | tr -d '\n\000')"
if [ "$useras" != "$invalid" ] # Some characters were stripped
then
	echo "Error: invalid user-as" >&2
	exit 1
fi

# Query git config
name="$(git config --get "users.$useras.name")"
if [ $? -eq 1 ]
then
	echo "Error: could not find 'users.$useras.name'" >&2
	exit 1
fi

email="$(git config --get "users.$useras.email")"
if [ $? -eq 1 ]
then
	echo "Error: could not find 'users.$useras.email'" >&2
	exit 1
fi

echo "git-commitas: committing as \"$name\" <$email>"

exec env "GIT_AUTHOR_NAME=$name" "GIT_AUTHOR_EMAIL=$email" \
	"GIT_COMMITTER_NAME=$name" "GIT_COMMITTER_EMAIL=$email" \
	git commit "$@"