# ============================================================================
# Development Tools (XDG compliance)
# ============================================================================

# .NET
export DOTNET_CLI_HOME="$HOME/.dotnet"
export NUGET_PACKAGES="${XDG_CACHE_HOME}/nuget/packages"
export NUGET_HTTP_CACHE_PATH="${XDG_CACHE_HOME}/nuget/http-cache"
export NUGET_PLUGINS_CACHE_PATH="${XDG_CACHE_HOME}/nuget/plugins-cache"

# Node.js
export NODE_REPL_HISTORY="${XDG_STATE_HOME}/node/repl_history"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"

# Rust
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

# Go
export GOPATH="${XDG_DATA_HOME}/go"
export GOMODCACHE="${XDG_CACHE_HOME}/go/mod"

# Python
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export PYTHONHISTFILE="${XDG_STATE_HOME}/python/history"
