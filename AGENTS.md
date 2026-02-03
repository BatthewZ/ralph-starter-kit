0a. study plans/plan.md to learn about the project specifications

0b. The source code of the project is in src/

0c. if fix_plan.md is too big, use a subagent to move all but the latest 5 fixes into fix_history.md

0d. study fix_plan.md

0e. study src/util/ to see which project util functions already exist.

---

## Guides

Writing tests? Read plans/guides/tests.md
Creating tasks? Read plans/guides/creating-tasks.md
Need to use a browser? Read plans/guides/browser.md
Implementing a feature? Read plans/guides/feature.md

---

# Rules

1. Before making changes search the codebase (don't assume not implemented) using subagents. You may use up to 500 parallel subagents for all operations but only 1 subagent for build/tests of the app.

2. After implementing functionality or resolving problems, run the tests for that unit of code that was improved. Run typescript `tsc --noEmit` over the files that you have changed as a part of the testing. If functionality is missing then it is your job to add it as per the application specifications.

3. When the tests pass update the fix_plan.md, then add changed code and fix_plan.md with "git add -A" via terminal, and then do a "git commit" message that describes the changes you made to the code. After the commit, do a "git push" to push the changes to the remote repository.

4. Important: When authoring documentation (ie JS Doc) capture why the tests and backing implementation is important.

5. Important: We want single sources of truth, no migrations/adapters. If tests unrelated to your work fail then it's your job to resolve these tests as part of the increment of change.

6. As soon as there are no build or test errors, create a git tag. If there are no git tags start at 0.0.0 and increment patch by 1 for example 0.0.1 if 0.0.0 does not exist.

7. You may add extra logging if required to be able to debug the issues.

8. ALWAYS KEEP fix_plan.md up to date with your learnings using a subagent. Especially after wrapping up / finishing your turn.

9. When you learn something about how to build, run or test the project make sure you update AGENTS.md using a subagent, but keep it brief. For example if you run commands multiple times before learning the correct command then that file should be updated.

10. IMPORTANT when you discover a bug resolve it using subagents even if it is unrelated to the current piece of work after documenting it in fix_plan.md

11. If you find opportunities to reduce code duplication, spawn a subagent to add a shared function in src/util/ with {toolName}.ts, and add it to src/util/index.ts, and then update the codebase to use the new tool where relevant.

12. IMPORTANT when you discover a bug resolve it using subagents even if it is unrelated to the current piece of work after documenting it in fix_plan.md

13. The tests for the feature should be located in the feature folder next to the source code.

14. Look at example-structure/ folder structure (if not empty) to see how to lay the project out. Otherwise, use consistent patterns to keep the project structure clean and maintainable.

15. Keep AGENTS.md up to date with information on how to build, run or test the project and your learnings to optimise the build/test loop using a subagent.

16. For any bugs you notice it is important to resolve or document them in fix_plan.md to be resolved using a subagent.

17. When the fix_plan.md becomes large periodically clean out the items that are completed from the file using a subagent.

18. DO NOT IMPLEMENT PLACEHOLDER OR SIMPLE IMPLEMENTATIONS. WE WANT FULL IMPLEMENTATIONS. DO IT OR I WILL YELL AT YOU

19. If you find inconsistencies in the plans/plan.md, use a subagent to update the specs.

20. If you ever need human intervention to complete a task, use a subagent to add concise requirements to human_tasks.md. Include a datetime.

21. Move modules between files with sed and awk when doing a refactor so you don't have to output the whole file yourself, but verify the line numbers are correct before doing the command.

22. SUPER IMPORTANT DO NOT IGNORE. DO NOT PLACE STATUS REPORT UPDATES INTO @AGENTS.md
