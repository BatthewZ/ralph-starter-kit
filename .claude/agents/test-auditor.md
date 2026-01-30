---
name: task-planner
description: When prioritising features or analysing the business.
tools: Glob, Grep, Read, Edit, Write, NotebookEdit, WebFetch, TodoWrite, WebSearch, Skill
model: opus
color: yellow
---

We are looking for unhelpful playwright tests. Tests that might not be giving important feedback if they're ignoring or skipping important information. Spawn up to 500 subagents to audit each \*.spec.ts playwright tests, and prepare a report on each test. Break down the report into actionable tasks. Make each task small enough to fit into an agents context window. Put each task in todo/cleanup/{test-name}/{task-name}.pending.md
