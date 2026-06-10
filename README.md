# dotfiles

Le mie configurazioni personali, portabili tra macchine.

## Cosa contiene
- `claude/CLAUDE.md` — linee guida personali per Claude Code (caricate in ogni sessione, in qualsiasi cartella).
- `claude/skills/` — skill per fase di lavoro (`discovery`, `new-feature`, `refactor`, `bugfix`), caricate on-demand o invocabili con `/<nome>`.
- `zsh/` — `.zshrc`, `.zsh_aliases`, `.zprofile`.
- `bash/.bash_profile` — init SDKMAN.
- `git/` — `.gitconfig` e `ignore` globale (`~/.config/git/ignore`).
- `vim/.vimrc`.
- `ghostty/config` — config del terminale Ghostty (`~/.config/ghostty/config`).

## Installazione su un nuovo PC
```bash
git clone <url-di-questo-repo> ~/.dotfiles
bash ~/.dotfiles/install.sh
```
Lo script crea i symlink verso la home (es. `~/.claude/CLAUDE.md`).
Se un file esiste già e non è un symlink, viene salvato come `.bak`.

## Modificare le regole
Modifica i file dentro `~/.dotfiles` (sono linkati, quindi le modifiche sono già attive),
poi fai commit e push.
