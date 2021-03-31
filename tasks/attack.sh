#!/bin/sh

# Puppet Task Name: attack
#
# This task will only work if Gremlin is already installed on the system.
# Daemon isn't required, but you need everything configured to work.

# First we verify gremlin can actually be found.
gremlin_exec () {
  if ! command -v gremlin &> /dev/null
  then
  # Failing a path check, we see if it's in the default directory as one last hoorah.
    if test -f "/bin/gremlin"
    then
      gremlin_run="/bin/gremlin"
    else
        echo "Gremlin agent not found."; exit 1
    fi
  else
    gremlin_run="gremlin"
  fi
}

gremlin_exec

$gremlin_run attack $PT_attack $PT_flags