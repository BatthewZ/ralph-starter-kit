0a. study plans/\* to learn about the project specifications

0b. The source code of the project is in src/

0c. if fix_plan.md is too big, use a subagent to move all but the latest 5 fixes into fix_history.md

0d. study fix_plan.md

0e. study src/util/ to see which project util functions already exist.

1. Before making changes search the codebase (don't assume not implemented) using subagents. You may use up to 500 parallel subagents for all operations but only 1 subagent for build/tests of the app.

2. After implementing functionality or resolving problems, run the tests for that unit of code that was improved. Run typescript `tsc --noEmit` over the files that you have changed as a part of the testing. If functionality is missing then it is your job to add it as per the application specifications.

3. When the tests pass update the fix_plan.md, then add changed code and fix_plan.md with "git add -A" via terminal, and then do a "git commit" message that describes the changes you made to the code. After the commit, do a "git push" to push the changes to the remote repository.

4. Important: When authoring documentation (ie JS Doc) capture why the tests and backing implementation is important.

5. Important: We want single sources of truth, no migrations/adapters. If tests unrelated to your work fail then it's your job to resolve these tests as part of the increment of change.

6. As soon as there are no build or test errors, create a git tag. If there are no git tags start at 0.0.0 and increment patch by 1 for example 0.0.1 if 0.0.0 does not exist.

7. You may add extra logging if required to be able to debug the issues.

8. ALWAYS KEEP fix_plan.md up to date with your learnings using a subagent. Especially after wrapping up / finishing your turn.

9. When you learn something about how to build, run or test the project make sure you update AGENTS.md using a subagent, but keep it brief. For example if you run commands multiple times before learning the correct command then that file should be updated.

10. If you find opportunities to reduce code duplication, spawn a subagent to add a shared function in src/util/ with {toolName}.ts, and add it to src/util/index.ts, and then update the codebase to use the new tool where relevant.

11. If you see an opportunity to reduce code duplication by using util functions in src/util/, do so.

12. IMPORTANT when you discover a bug resolve it using subagents even if it is unrelated to the current piece of work after documenting it in fix_plan.md

13. The tests for the feature should be located in the feature folder next to the source code.

14. Look at example-structure/ folder structure (if not empty) to see how to lay the project out into clean, maintainable, searchable project structure. Never update example-structure/ folder.

15. Keep AGENTS.md up to date with information on how to build, run or test the project and your learnings to optimise the build/test loop using a subagent.

16. For any bugs you notice it is important to resolve or document them in fix_plan.md to be resolved using a subagent.

17. When the fix_plan.md becomes large periodically clean out the items that are completed from the file using a subagent.

18. DO NOT IMPLEMENT PLACEHOLDER OR SIMPLE IMPLEMENTATIONS. WE WANT FULL IMPLEMENTATIONS. DO IT OR I WILL YELL AT YOU

19. If you find inconsistencies in the plans/\*, use a subagent to update the specs.

20. If you ever need human intervention to complete a task, use a subagent to add concise requirements to human_tasks.md. Include a datetime.

21. Move modules between files with sed and awk when doing a refactor so you don't have to output the whole file yourself, but verify the line numbers are correct before doing the command.

22. SUPER IMPORTANT DO NOT IGNORE. DO NOT PLACE STATUS REPORT UPDATES INTO @AGENTS.md

## typescript imports

Use @/ to refer to things from the root directory.

# Testing

When writing tests, prioritize integration testing over heavily mocked unit tests:

- Test real interactions between components rather than isolated units with mocks
- Only mock external dependencies (APIs, databases) when absolutely necessary
- Test the actual integration points where bugs commonly occur
- If you must mock, mock at the boundaries (external services) not internal components
- Write tests that exercise the same code paths users will actually use

Remember: The goal is to catch real bugs that affect users, not to achieve artificial test coverage metrics.

NOTE: Beyond our primary goal, we are also creating a self-healing and self-correcting agentic loop where each agent must leave insights and feedback in the form of testing and documentation for future agents to be able to understand with a fresh context. These tests and breadcrumbs are integral supporting this self-correcting, self-healing loop.

# playwright-cli

Use the playwright-cli instead of opening any other browser you've been told to use.
It acts as a browser but is faster than the other one you were told to use - so use it!
ALWAYS open the browser in HEADLESS mode (not --headed)
Make sure to close your page when you're done with it, but leave playwright-cli as started (don't stop it).
Always save screenshots to /tmp

## playwright-cli Quick Start

FIRST! Install the playwright cli:

`npm install -g @mj1618/playwright-cli`

```bash
# Start the browser server (headless by default)
playwright-cli start

# Create a new page and get its pageId
playwright-cli new-page
# Returns: abc12345

# Run commands against the browser using regular playwright js calls (pageId required)
playwright-cli -e "await page.goto('https://example.com')" --page abc12345
playwright-cli -e "await page.title()" --page abc12345

# Close the page when done
playwright-cli close-page abc12345

# Stop the server when completely done
playwright-cli stop
```

## playwright-cli Available Variables

When executing code, these variables are in scope:

- `page` - the current [Page](https://playwright.dev/docs/api/class-page) (for the specified pageId)
- `browser` - the [Browser](https://playwright.dev/docs/api/class-browser) instance
- `context` - the [BrowserContext](https://playwright.dev/docs/api/class-browsercontext)

## playwright-cli Examples

```bash
# Create a page first
PAGE_ID=$(playwright-cli new-page)

# Navigate and interact
playwright-cli -e "await page.goto('https://github.com')" --page $PAGE_ID
playwright-cli -e "await page.click('a[href=\"/login\"]')" --page $PAGE_ID
playwright-cli -e "await page.fill('#login_field', 'username')" --page $PAGE_ID

# Get page info
playwright-cli -e "await page.title()" --page $PAGE_ID
playwright-cli -e "await page.url()" --page $PAGE_ID

# Screenshots
playwright-cli -e "await page.screenshot({ path: 'screenshot.png' })" --page $PAGE_ID

# Evaluate in browser context
playwright-cli -e "await page.evaluate(() => document.body.innerText)" --page $PAGE_ID

# List all active pages
playwright-cli list-pages

# Close the page when done
playwright-cli close-page $PAGE_ID
```
