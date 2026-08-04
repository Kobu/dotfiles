# Public/private commit boundaries

This repository has a private workstation history and a public counterpart.
Keep the history intentionally separable: a generic desktop change should be
able to move to the public repository without bringing private workstation or
work-related configuration with it.

## Commit rules

- Make one focused commit per concern. For example, keep Kitty, Polybar,
  Awesome, Picom/Rofi, Dunst, Fastfetch, and local desktop utilities separate
  when their changes are independent.
- Do not mix a generally useful desktop change with shell profiles, Git
  identity/credentials, work tooling, private editor workspaces, or personal
  documentation in the same commit.
- If a file contains both public and private changes, split them into separate
  commits. When that is not practical, create a clean public-only commit rather
  than cherry-picking a mixed commit.
- Keep commit messages descriptive and subsystem-scoped, for example
  `kitty: ...`, `polybar: ...`, or `desktop: ...`.

## Treat as private unless explicitly reviewed

Do not include these in a public-bound commit without an explicit review:

- credentials, tokens, keys, cookie files, credential helpers, or paths to
  their source files;
- work email addresses, internal hosts, domains, proxies, cluster/context
  names, project names, and environment-specific aliases;
- shell profile setup, Git identity/configuration, private vault/workspace
  paths, or editor configuration that refers to private projects;
- generated state, caches, databases, logs, and machine-specific secrets.

Never print a suspected credential while reviewing it. If one is found in any
commit history, stop the public-release work and report that it must be
revoked/rotated and removed from the public branch's ancestry.

## Preparing a public update

1. Start a dedicated local branch from the public remote's default branch.
2. Cherry-pick only commits that are independently public-safe. Resolve a
   conflict by preserving the public baseline and applying only the reviewed,
   generic portion of the change.
3. Review the complete branch diff—not just commit messages—for credentials,
   internal references, and private paths. Also run applicable syntax or
   configuration checks.
4. Keep the private branch unchanged. Do not push the public branch unless the
   user explicitly asks to push it.

When in doubt, keep a change private and ask the user whether a clean public
version should be created.
