---
name: commit
description: Split requested Git changes into logical local commits.
disable-model-invocation: true
---

# Commit

Turn requested changes in the current Git worktree into clean, self-contained
local commits. Preserve unrelated work and account for every in-scope hunk.

## Guardrails

- Keep commits local. Do not push, amend, or rewrite existing commits.
- Capture the starting worktree before staging. Treat it as the baseline: commit
  only requested changes present in that inventory or created explicitly for
  this run; leave unrelated changes untouched.
- Keep secrets out of commits: `.env` files, credentials, tokens, and private
  keys. If an intended change contains one, stop and ask before staging it.
- Preserve worktree content while changing the index. Use index-only staging
  operations and patch staging when a file spans groups.

## Workflow

1. **Inventory the baseline.** Run `git status --short`, `git diff --stat`,
   `git diff --cached --stat`, `git diff`, and `git diff --cached`. Inspect every
   untracked file or directory. Completion: every worktree change is visible
   and its staged, unstaged, or untracked state is known.

2. **Define scope and groups.** Classify every file and hunk as an in-scope
   group, unrelated work, or blocked secret. Group by one conceptual change;
   keep its required tests, docs, and configuration together. Split files that
   contain multiple changes with patch staging. Order dependent groups from
   prerequisite to consumer. Ask when intent or ownership is unclear.
   Completion: every in-scope hunk belongs to exactly one group, and unrelated
   or blocked changes are identified.

3. **Discover the checks.** Find repository-configured hooks and relevant
   lint, typecheck, test, or format commands. Use the narrowest applicable
   checks for each group; use a configured commit hook when it is the check.
   Do not invent project commands. Completion: each group has a check that is
   passed, hook-managed, or explicitly unavailable.

4. **Commit each group in dependency order.** For one group at a time:
   - Arrange the index to contain exactly that group's hunks with `git add` or
     `git add -p`; remove unrelated staged hunks with
     `git restore --staged -p`.
   - Review `git diff --cached` and `git status --short`. Confirm the staged
     diff contains no secret or unrelated hunk, then run the group's checks and
     `git diff --cached --check`.
   - Write the message with `caveman-commit`: conventional format, imperative
     subject, and a body only when the why is non-obvious. Then run `git commit`.
   - If a hook fails or changes files, inspect the resulting index and worktree
     diff before fixing or accepting the commit.
   Completion: the new commit exists and `git show HEAD` matches exactly the
   intended group.

5. **Reconcile the result.** Run `git log --oneline -n <N>` where `N` is the
   number of commits created, then run `git status --short` and compare it with
   the baseline. Completion: every requested hunk is in exactly one new local
   commit, unrelated or blocked work remains uncommitted, and no worktree
   content was lost.
