## ast-grep with R support

<!-- from https://emilhvitfeldt.com/post/ast-grep-r-claude-code/ -->

R language support is configured globally via `~/.config/ast-grep/sgconfig.yml`.

Usage:
\```bash
sg -l r -p 'pattern' .
\```

Note: Use `_VAR` for named metavariables and `___` for wildcards (not `$VAR`) because R uses `$` for list-column access.
