#!/bin/bash
command -v ya >/dev/null || exit 0
ya pkg add yazi-rs/plugins:git 2>/dev/null || true   # already added = fine
ya pkg install                                       # installs anything listed but missing
