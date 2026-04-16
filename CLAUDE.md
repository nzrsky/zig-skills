# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A collection of AI coding assistant skills providing verified Zig 0.16.0 API documentation (with migration notes from 0.15.x). This is a **documentation-only repository** — no build system, no tests, no compiled code. The content prevents LLMs from generating Zig code with deprecated/removed APIs from outdated training data.

## Repository Structure

```
skills/zig/
  SKILL.md              # Main skill file — frontmatter + all breaking changes, quick fixes, patterns
  references/           # 57 markdown reference files for std library modules, patterns, tooling
.agent/skills/zig/      # IDE mirror — Agent
.cursor/skills/zig/     # IDE mirror — Cursor
.opencode/skills/zig/   # IDE mirror — OpenCode
.codex/skills/zig/      # IDE mirror — Codex
.gemini/skills/zig/     # IDE mirror — Gemini CLI
.continue/skills/zig/   # IDE mirror — Continue
.kilocode/skills/zig/   # IDE mirror — Kilocode
.factory/skills/zig/    # IDE mirror — Factory AI
.adal/skills/zig/       # IDE mirror — AdaL CLI (Sylph AI)
.codebuddy/skills/zig/  # IDE mirror — CodeBuddy
.openclaw/skills/zig/   # IDE mirror — OpenClaw
.pi/skills/zig/         # IDE mirror — Pi Agent
.kiro/steering/         # IDE mirror — Kiro (steering file format)
.claude-plugin/         # Plugin metadata (plugin.json, marketplace.json)
scripts/                # sync-ide-folders.sh
```

`skills/zig/` is the canonical source. All IDE directories are mirrors.

`SKILL.md` is the entry point. It contains the YAML frontmatter (skill metadata), breaking changes (removed features, I/O rewrite, build system changes, container init), quick fixes table, and an index linking to every reference file.

The `references/` files are standalone — each covers one std library module or topic (e.g., `std-arraylist.md`, `std-hashmap.md`, `patterns.md`, `production-patterns.md`).

## Working on This Repo

All content is markdown. There is no build step, linter, or test suite.

When editing:
- Edit files in `skills/zig/` (canonical source), then run `bash scripts/sync-ide-folders.sh` to propagate to all IDE directories
- Use `bash scripts/sync-ide-folders.sh --verify` to check all directories are in sync
- Code examples in markdown must target **Zig 0.16.0** (with 0.15.x migration notes where relevant) — always show WRONG (old) vs CORRECT (new) patterns for breaking changes
- `SKILL.md` frontmatter fields (`name`, `description`, `license`, `compatibility`, `metadata`) follow the skills format used by `npx skills`
- Reference files are self-contained; each should work standalone without requiring other files to be loaded

## Key Conventions

- Breaking changes follow the pattern: section header, WRONG code block (old API), CORRECT code block (new API), brief explanation
- The Quick Fixes table in `SKILL.md` maps compiler error messages to one-line fixes
- Reference file naming: `std-{module}.md` for std library, plain names for concepts (`patterns.md`, `comptime.md`, `language.md`)
