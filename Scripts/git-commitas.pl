#!/usr/bin/perl

use v5.26;

my $USAGE = <<~END;
	Usage: git commitas <as-user> <arguments>
	       git commitas --help | -h
	       git commitas --man
	END

my $MAN = <<~END;
	$USAGE
	This script overrides the GIT_AUTHOR_* and GIT_COMMITTER_* environment variables
	with git config values users.<as-user>.name and users.<as-user>.email.

	For a user named John, you would add this to your git config:
	```
	[users "John"]
		name = "John Doe"
		email = "john.doe\@example.com"
	```
	And call it as so: git commitas John <arguments>

	Note that <as-user> is case-sensitive and can not start with a hyphen.

	Dependencies: bash, perl, env

	Licensed by Tilwa Qendov under The Artistic 2.0 license
	END

# Check arguments
my $useras = shift @ARGV;
unless ($useras) {
	say STDERR "Error: missing user name";
	print STDERR $USAGE;
	exit 1;
}

# Handle help, manual and unknown flags
if ($useras eq '--help' || $useras eq '-h') {
	print $USAGE;
	exit 0;
} elsif ($useras eq '--man') {
	print $MAN;
	exit 0;
} elsif ($useras =~ /^-/) {
	say STDERR "Error: unknown flag '$useras'";
	exit 1;
}

# Filter invalid characters
# NB: command line can't contain the null byte anyways
my $invalid = $useras =~ s/[\n\0]//g;
if ($invalid) {
	say STDERR "Error: invalid user-as";
	exit 1;
}

# Quote for shell
my $useras_e = $useras =~ s/'/'\\''/gr;
$useras_e = qq('$useras');

# Query git config
my $name  = qx[ git config --get users.$useras_e.name ];
chomp $name;
if ($? >> 8 == 1) {
	say STDERR "Error: could not find 'users.$useras.name'";
	exit 1;
}

my $email = qx[ git config --get users.$useras_e.email ];
chomp $email;
if ($? >> 8 == 1) {
	say STDERR "Error: could not find 'users.$useras.email'";
	exit 1;
}

say qq(git-commitas: Committing as "$name" <$email>);

my @command = @ARGV;

# Add our command
unshift @command, "git", "commit";

# Add our environment variables
unshift @command, "GIT_AUTHOR_NAME=$name";
unshift @command, "GIT_AUTHOR_EMAIL=$email";
unshift @command, "GIT_COMMITTER_NAME=$name";
unshift @command, "GIT_COMMITTER_EMAIL=$email";

unshift @command, "env";

exec { $command[0] } @command;
