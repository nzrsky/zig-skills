# Zig Skills for AI Coding Assistants

AI coding assistant skills providing verified, version-specific Zig API documentation and best practices. Prevents LLMs from generating code with deprecated or removed APIs.

## Available Skills

| Skill | Description | Target Version |
|-------|-------------|----------------|
| [zig](./zig/) | Zig language API guide with 60+ reference files | Zig 0.15.x |

## Why?

Most LLM training data contains outdated Zig patterns (0.11-0.13 era) that cause compilation errors on modern Zig. Common mistakes include:

- Using `root_source_file` instead of `root_module` in build.zig
- Old I/O API (`std.io.getStdOut().writer()`) instead of new buffered writer pattern
- `std.ArrayList` without passing allocator to every method (now unmanaged by default)
- PascalCase `@typeInfo` fields (`.Struct`) instead of lowercase (`.@"struct"`)
- Using removed features: `async`/`await`, `usingnamespace`, `BoundedArray`

This skill catches all of these and 50+ more breaking changes.

## What's Included

### Main Skill (`SKILL.md`)
- Design principles (type-first development, make illegal states unrepresentable)
- All breaking changes from 0.14/0.15 with WRONG/CORRECT examples
- I/O API rewrite ("Writergate") patterns
- Build system migration guide
- Container initialization rules (`.empty`/`.init`)
- Quick fixes error table (14 common errors with solutions)
- Verification workflow
- Common pitfalls checklist

### Reference Files (60+ files in `references/`)
- Complete std library API references (ArrayList, HashMap, JSON, HTTP, crypto, etc.)
- Language basics, builtins, comptime metaprogramming
- Production patterns from Bun, Ghostty, TigerBeetle
- MCP server patterns for protocol translators
- Code review checklist organized by confidence level
- Style guide, C interop, build system deep-dive

## Installation

### Claude Code (recommended)

```bash
# Install via skills.sh
claude install-skill https://skills.sh/nzrsky/zig-skills/zig
```

Or manually:
```bash
# Clone into your Claude skills directory
git clone https://github.com/nzrsky/zig-skills.git ~/.claude/skills/zig-skills

# Or copy just the skill you need
cp -r zig-skills/zig ~/.claude/skills/zig
```

### OpenCode / Codex

Reference `SKILL.md` in your project configuration or conversation context.

### Manual

Add to your project's `CLAUDE.md`:
```markdown
When writing Zig code, load and follow the patterns in `skills/zig/SKILL.md`.
```

## Compatibility

- **Claude Code** - Full support via skills system
- **OpenCode** - Compatible skill format
- **Codex** - Load as context document
- **Any LLM** - Reference SKILL.md as system prompt or context

## License

MIT
