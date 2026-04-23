---
name: code-review
description: Reviews uncommitted code changes for TypeScript typing, SOLID, DRY, and Clean Code standards. Use when the user types /review or asks to review uncommitted code.
---

# Code Review Skill

This skill allows the agent to perform a comprehensive code review of uncommitted changes (staged and unstaged).

> Original skill authored by **Alex Firlot** — [`richelieu/crm-api@feature/RICRM-206`](https://gitlab.cybercat.priv/richelieu/crm-api/-/blob/feature/RICRM-206/.cursor/skills/code-review/SKILL.md).
> Packaged here unchanged for distribution via the shared `cybercat-plugin`.

## Instructions

When the user requests a review (e.g., via `/review` or by asking to "review my changes"), follow these steps:

1.  **Gather Changes**: 
    - Run `git diff -w HEAD` to retrieve changes to tracked files (ignoring whitespace).
    - Run `git ls-files --others --exclude-standard` to find untracked (new) files.
    - Read the content of any untracked files discovered.
    - If no changes are found in either command, inform the user.
2.  **Analyze Code**: Systematically review the changes for the following:
    *   **TypeScript Typing**: Check for adequate, explicit, and accurate types. Avoid `any` where possible.
    *   **SOLID Principles**: Ensure Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, and Dependency Inversion are respected.
    *   **DRY Principle**: Identify any unnecessary logic duplication.
    *   **Clean Code Standards**: Evaluate naming conventions, function size, readability, and overall structure.
    *   **NodeJS/Express Best Practices**: Check for proper error handling (async/await), security (middleware), performance, and project structure conventions.
3.  **Report Issues**: Number each issue sequentially (starting from `#1`) across the entire report so the user can reference them in chat (e.g. "fix #3"). For each identified issue, provide:
    *   **Problem**: A clear explanation of what is wrong and why.
    *   **Location**: The file path and approximate line numbers.
    *   **Solution**: A concrete code example or refactoring suggestion to fix the issue.

## Examples

**User**: /review
**Agent**: *Runs `git diff HEAD` and `git ls-files --others --exclude-standard`, reads new files, analyzes everything, and provides a structured report.*

### Example Report Format:

**File: `src/services/UserService.ts`**
*   **#1 🔴 Issue (SOLID/SRP)**: The `updateUser` function is also handling email notifications.
    *   **Solution**: Extract the notification logic into a dedicated `NotificationService`.
*   **#2 🟡 Issue (TypeScript)**: The `data` parameter in `processUser` is typed as `any`.
    *   **Solution**: Define an interface `UserData` and use it for the `data` parameter.
