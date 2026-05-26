# aconfmgr cheatsheet

Config manager for Arch. Tracks explicitly-installed packages + `/etc` files.

## Commands

| Cmd | Reads | Writes config | Writes system |
|-----|-------|---------------|---------------|
| `aconfmgr check` | system + config | no | no |
| `aconfmgr save`  | system | yes (`99-unsorted.sh`) | no |
| `aconfmgr apply` | config | no | yes (prompts) |

## Daily loop (single host)

```
# made manual changes? capture them:
aconfmgr save
# sort 99-unsorted.sh into 20-packages.sh / 30-files.sh / etc
```

## Sync across hosts (desktop ↔ notebook)

Before pulling:
```
aconfmgr check                 # drift? save + commit FIRST
```

Then:
```
git pull
aconfmgr apply                 # preview → confirm
aconfmgr check                 # expect clean
```
