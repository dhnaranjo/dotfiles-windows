# Desmond Naranjo's dotfiles for Windows
(Forked from Jay Harris's excellent dotfiles for Windows)

## Installation
### Using Git and the bootstrap script
From PowerShell:
```posh
git clone https://github.com/jayharris/dotfiles-windows.git; cd dotfiles-windows; . .\bootstrap.ps1

To update your settings, `cd` into your local `dotfiles-windows` repository within PowerShell and then:

```posh
. .\bootstrap.ps1
```

Note: You must have your execution policy set to unrestricted (or at least in bypass) for this to work: `Set-ExecutionPolicy Unrestricted`.

### Git-free install
### Sensible Windows defaults
```posh
.\windows.ps1
```
### Install dependencies and packages
Add any must-have applications or tools to this file and run. Should re-run safely.
```posh
.\deps.ps1
```