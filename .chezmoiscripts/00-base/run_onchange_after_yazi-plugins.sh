#!/bin/bash
command -v ya >/dev/null || exit 0
ya pkg install     # restores every plugin at the revision pinned in package.toml
