# gitu

Mini CLI for common git flows.

## Requirements

- A POSIX shell (sh, [bash](https://www.gnu.org/software/bash/), [zsh](https://www.zsh.org/), dash, etc.)
- [git](https://git-scm.com/)

## Installation

```sh
curl -fsSL https://raw.githubusercontent.com/luisvillegasbf23/gitu/main/src/install.sh | sh
```

## Usage

```text
gitu                    Show help
gitu push <branch> <message> <file> [file2 ...]   Add, commit and push
gitu clean              Switch to master/main and delete all other local branches
gitu who                 Show current git user and remote
gitu uninstall           Remove gitu from this machine
```

### Examples

```sh
gitu push main "fix: update dependencies" .
gitu push main "feat: add login" src/login.js src/styles.css
gitu clean
gitu who
gitu uninstall
```

## License

[Apache-2.0](LICENSE)
