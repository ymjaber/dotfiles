# dotfiles

Personal Arch Linux configuration

## Bootstrap a new machine

```bash
curl -fsSL https://raw.githubusercontent.com/ymjaber/dotfiles/main/bootstrap.sh
```

If this machine needs the encrypted files (secrets), first restore the age key from the
password manager (secure note "age key") to `~/.config/chezmoi/key.txt`.

What happens automatically: chezmoi asks this machine's interview questions once (role,
gpu, city, ...), builds paru if missing, runs every use case's own package installer,
writes every config, and enables services. Re-running `chezmoi apply` is always safe -
it only fixes drift.

## Layout (modular: one folder per use case)

- `.chezmoiscripts/<use-case>/` - that use case's automation, self-contained: its own
  `run_onchange_before_10-packages.sh` (the inline list IS its package record - editing
  the list re-runs just that installer), plus any of its services/setup scripts
- everything else mirrors its real path in $HOME; a use case's configs are the files
  named after it at the hook points (shell modules, editor plugin files, widgets)

## Daily verbs

- `chezmoi apply` - make the machine match the repo
- `chezmoi diff` - what would change
- `chezmoi cd` - enter this repo
- `doctor` - is my system whole?
