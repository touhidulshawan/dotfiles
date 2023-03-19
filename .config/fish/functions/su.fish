#!/usr/bin/fish

# Date Created: 20-03-2023
# Date Modified: 20-03-2023

# Description
# If su starts with Bash because Bash is the target user's (root if no username is provided) default shell, one can define a function to redirect it to fish whatever the user's shell

function su
    command su --shell=/usr/bin/fish $argv
end
