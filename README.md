# Zig Skills for AI Coding Assistants

AI coding assistant skills providing verified, version-specific Zig API documentation and best practices. Prevents LLMs from generating code with deprecated or removed APIs.

## Available Skills

| Skill | Description | Target Version |
|-------|-------------|----------------|
| [zig](./skills/zig/) | Zig language API guide with 57 reference files | Zig 0.17.0-dev |

## Why?

Most LLM training data contains outdated Zig patterns (0.11-0.14 era) that cause compilation errors on modern Zig. Common mistakes include:

- Using `std.net` instead of `std.Io.net` (0.16 — networking requires `Io` instance)
- Calling `std.time.timestamp()` instead of `std.c.clock_gettime` (0.16 — removed)
- Using `std.Thread.Mutex`/`Condition`/`sleep` instead of POSIX pthreads (0.16 — removed)
- Using `std.crypto.random` instead of `arc4random_buf` (0.16 — removed)
- Calling `lib.addIncludePath(...)` instead of `lib.root_module.addIncludePath(...)` (0.16 — moved)
- Using `root_source_file` instead of `root_module` in build.zig (0.15)
- Old I/O API (`std.io.getStdOut().writer()`) instead of new buffered writer pattern (0.15)
- `std.ArrayList` without passing allocator to every method (now unmanaged by default)
- PascalCase `@typeInfo` fields (`.Struct`) instead of lowercase (`.@"struct"`)
- Using removed features: `async`/`await`, `usingnamespace`, `BoundedArray`

This skill catches all of these and dozens more breaking changes.

## What's Included

### Main Skill (`SKILL.md`)
- Design principles (type-first development, make illegal states unrepresentable)
- All breaking changes from 0.14/0.15/0.16 with WRONG/CORRECT examples
- 0.16 migration: networking (`std.Io.net`), time, threading, crypto, debug, build system
- I/O API rewrite ("Writergate") patterns
- Build system migration guide (including `Compile.*` → `Module.*` for 0.16)
- Container initialization rules (`.empty`/`.init`)
- Quick fixes error table (25 common errors with solutions)
- Version managers: zigup, anyzig
- Verification workflow
- Common pitfalls checklist

### Reference Files (57 files in `references/`)
- Complete std library API references (ArrayList, HashMap, JSON, HTTP, crypto, etc.)
- Language basics, builtins, comptime metaprogramming
- Production patterns from Bun, Ghostty, TigerBeetle
- MCP server patterns for protocol translators
- Code review checklist organized by confidence level
- Style guide, C interop, build system deep-dive

## Supported IDEs

| Directory | IDE | Format |
|-----------|-----|--------|
| `skills/zig/` | Canonical source | SKILL.md + references/ |
| `.agent/skills/zig/` | Agent | SKILL.md + references/ |
| `.cursor/skills/zig/` | Cursor | SKILL.md + references/ |
| `.opencode/skills/zig/` | OpenCode | SKILL.md + references/ |
| `.codex/skills/zig/` | Codex | SKILL.md + references/ |
| `.gemini/skills/zig/` | Gemini CLI | SKILL.md + references/ |
| `.continue/skills/zig/` | Continue | SKILL.md + references/ |
| `.kilocode/skills/zig/` | Kilocode | SKILL.md + references/ |
| `.factory/skills/zig/` | Factory AI | SKILL.md + references/ |
| `.adal/skills/zig/` | AdaL CLI (Sylph AI) | SKILL.md + references/ |
| `.codebuddy/skills/zig/` | CodeBuddy | SKILL.md + references/ |
| `.openclaw/skills/zig/` | OpenClaw | SKILL.md + references/ |
| `.pi/skills/zig/` | Pi Agent | SKILL.md + references/ |
| `.kiro/steering/` | Kiro | zig-skill.md (steering file) |

## Installation

### Claude Code (recommended)

```bash
# Install globally via npx skills
npx -y skills add https://github.com/nzrsky/zig-skills --skill zig --yes --global --agent claude-code
```

Or manually:
```bash
git clone https://github.com/nzrsky/zig-skills.git /tmp/zig-skills
cp -r /tmp/zig-skills/skills/zig ~/.claude/skills/zig
rm -rf /tmp/zig-skills
```

### Cursor

```bash
git clone https://github.com/nzrsky/zig-skills.git /tmp/zig-skills
cp -r /tmp/zig-skills/.cursor/skills your-project/.cursor/skills
rm -rf /tmp/zig-skills
```

### Codex / OpenCode / Gemini CLI / Other Agents

Copy the matching IDE directory into your project root:
```bash
git clone https://github.com/nzrsky/zig-skills.git /tmp/zig-skills
# Replace .codex with your IDE's directory name
cp -r /tmp/zig-skills/.codex your-project/.codex
rm -rf /tmp/zig-skills
```

### Kiro

```bash
git clone https://github.com/nzrsky/zig-skills.git /tmp/zig-skills
mkdir -p your-project/.kiro/steering
cp /tmp/zig-skills/.kiro/steering/zig-skill.md your-project/.kiro/steering/
rm -rf /tmp/zig-skills
```

### Manual

Add to your project's `CLAUDE.md`:
```markdown
When writing Zig code, load and follow the patterns in `skills/zig/SKILL.md`.
```

## Keeping IDE Directories in Sync

After editing files in `skills/zig/`, run:
```bash
bash scripts/sync-ide-folders.sh
```

To verify all directories match:
```bash
bash scripts/sync-ide-folders.sh --verify
```

## License

MIT
