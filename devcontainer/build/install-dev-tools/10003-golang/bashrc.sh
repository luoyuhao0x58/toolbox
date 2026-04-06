#! /bin/bash

if [[ -n $(alias g 2>/dev/null) ]]; then
    unalias g
fi
[ -s "${HOME}/.g/env" ] && \. "${HOME}/.g/env"
