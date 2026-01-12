# =============================================================================
# Basic Commands
# =============================================================================

alias g='git'
alias gs='git status'
alias gst='git status -sb'

# =============================================================================
# Add / Stage
# =============================================================================

alias ga='git add'
alias gaa='git add --all'
alias gap='git add -p'
alias gau='git add -u'

# =============================================================================
# Commit
# =============================================================================

alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gcam='git commit -am'

# =============================================================================
# Diff
# =============================================================================

alias gd='git diff'
alias gds='git diff --staged'
alias gdc='git diff --cached'
alias gdt='git difftool'
alias gdw='git diff --word-diff'

# =============================================================================
# Log
# =============================================================================

alias gl='git log --oneline -20'
alias gla='git log --oneline --all -20'
alias glog='git log --graph --oneline --all --decorate'
alias glg='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias grl='git reflog'

# =============================================================================
# Branch
# =============================================================================

alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbm='git branch -m'

# =============================================================================
# Checkout / Switch
# =============================================================================

alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout main || git checkout master'

alias gsw='git switch'
alias gswc='git switch -c'
alias gswm='git switch main || git switch master'

# =============================================================================
# Merge / Rebase
# =============================================================================

alias gm='git merge'
alias gma='git merge --abort'

alias grb='git rebase'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias grbm='git rebase main || git rebase master'

# =============================================================================
# Cherry Pick
# =============================================================================

alias gcp='git cherry-pick'
alias gcpc='git cherry-pick --continue'
alias gcpa='git cherry-pick --abort'

# =============================================================================
# Remote
# =============================================================================

alias gr='git remote'
alias grv='git remote -v'
alias gra='git remote add'

alias gf='git fetch'
alias gfa='git fetch --all --prune'

alias gpl='git pull'
alias gplr='git pull --rebase'

alias gps='git push'
alias gpsu='git push -u origin HEAD'
alias gpsf='git push --force-with-lease'

# ============================================================================
# Stash
# ============================================================================

alias gsh='git stash'
alias gshu='git stash -u'
alias gshp='git stash pop'
alias gshl='git stash list'
alias gsha='git stash apply'
alias gshd='git stash drop'
alias gshs='git stash show -p'

# =============================================================================
# Reset
# =============================================================================

alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias grhs='git reset HEAD --soft'

# =============================================================================
# Clean
# =============================================================================

alias gclean='git clean -fd'
alias gpristine='git reset --hard && git clean -dfx'

# =============================================================================
# Tags
# =============================================================================

alias gt='git tag'
alias gtl='git tag -l'
alias gta='git tag -a'
alias gtd='git tag -d'

# =============================================================================
# Worktree
# =============================================================================

alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtl='git worktree list'
alias gwtr='git worktree remove'

# =============================================================================
# Submodules
# =============================================================================

alias gsm='git submodule'
alias gsmu='git submodule update --init --recursive'
alias gsma='git submodule add'

# =============================================================================
# Misc
# =============================================================================

alias gbl='git blame'
alias gbs='git bisect'
alias gcount='git shortlog -sn'
alias gwhoami='git config user.name && git config user.email'

# =============================================================================
# Fuzzy Git Commands (requires fzf)
# =============================================================================

alias gfs='git fuzzy status'
alias gfb='git fuzzy branch'
alias gfl='git fuzzy log'
alias gfrl='git fuzzy reflog'
alias gfsh='git fuzzy stash'
alias gfd='git fuzzy diff'
