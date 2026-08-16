# dotfiles

Personal Arch Linux configuration

## Bootstrap a new machine

```bash
curl -fsSL https://raw.githubusercontent.com/ymjaber/dotfiles/main/bootstrap.sh
```

If this machine needs the encrypted files (secrets), first restore the age key from the
password manager (secure note "age key") to `~/.config/chezmoi/key.txt`.

What happens automatically: chezmoi builds paru if missing, installs every package each use
case declares, writes every config, and enables services. Some use cases ask a question the
first time (city for prayer times, GPU class, machine role) - each is asked once and stored
outside this repo.

Re-running `chezmoi apply` is safe: it restores managed files and runs new or changed
scripts. It does not reinstall a package you removed by hand, nor re-fix `/etc` files a
script wrote once - `doctor` reports both.

## Layout (modular: one folder per use case)

- `.chezmoiscripts/<use-case>/` - that use case's automation, self-contained: its own
  `run_onchange_before_packages.sh` (the inline list IS its package record - editing the
  list re-runs just that installer), plus any services/setup scripts it needs
- everything else mirrors its real path in $HOME; a use case's configs are the files
  named after it at the hook points (shell modules, editor plugin files, widgets)

Then:

chezmoi apply
doctor
cd ~/.local/share/chezmoi && git add -A && git commit -m "doctor with real checks; README accuracy" && git push

## Daily verbs

- `chezmoi apply` - make the machine match the repo
- `chezmoi diff` - what would change
- `chezmoi cd` - enter this repo
- `doctor` - is my system whole?
