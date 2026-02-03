# Hi!

This is a small ralph starter kit. It's draft, it's messy. It's here for me to use to explore this method in new projects, and so that I can share it with others and encourage them to give it a shot.

My projects typically involve typescript, but update your AGENTS.md to reflect your desired stack.

## The Concept - The Loop:

You are trying to refine the loop. You are maintaining the pipeline that allows agents to generate the code.

1. Plan
2. Build
3. Test / Document (get feedback)

The human, in many regards, should be a meta ralph loop.

Plan:
Your job is to have a clear understanding of the outcomes that you want your app and its features to achieve. Your job is now to plan - to consider architectural tradeoffs and to find ways to build and maintain a self-healing, self-correcting pipeline.

Build:
Unleash the ralphs! To begin with, maybe build 3 features out (~15 task files) to see where they're going right, and where they need assistance.

Test / Document:
You then need a stopping point to get feedback on how it's going. Look at the tests they're writing, and consider them against your understanding of the desired project outcomes.

The most important things you need to be aware is the intended architecture and outcomes of the app, and whether or not the tests safeguard those outcomes. The tests must give good feedback to new agents, and have the reason behind the tests documented as comments at the beginning of the test file.

## You need

- NodeJS
- Claude CLI
- Claude subscription (ideally a chonky one)

## DO THIS FIRST

Run `.scripts/init.sh` to make folders.

1. Have a chat with an agent about your app idea. Discuss architecture and tech stack choices.
2. Once you're satisfied that it has a deep understanding of your vision, tell it:

> I need you to plan this application to build. Have phases where the important features are done in the first phase and so on. Include tests of functionality, but don't focus on it too much. Never include time estimations or time considerations - instead, think in dependency chains. Write this out to plans/plan.md.

3. Once that's done, say the following:

> Study plans/plan.md. Come up with a list of features ordered by importance. Break these down into more manageable 'tasks' that will likely fit in a single agent context window. Write the broken down tasks into /todo/{feature-name}/{task-name}.pending.md

4. (optional): If you have a particular ideas on project structure, create an example structure in examples/

5. Finally, do any of these

- `.scripts/ralph.sh` (defaults to 20 iterations)
- `.scripts/ralph.sh 3` (3 iterations)
- `.scripts/ralph.sh 5 todo/00-my-feature/` (5 iterations but only pick up tasks in this folder)

## Guide

After you've created your app plan and prepared the initial tasks, and had ralph loop over it, here are things you can try.

- Use `.scripts/planner-ralph.sh` to create new features based on the plan. It will decide what to come up with. Its ideas are often surprisingly good. You can leave the planner running to generate features/task files, while other ralphs are consuming them and building.

- Correct them by updating AGENTS.md, by updating the scripts, or by adding new tasks (eg `.scripts/task-maker.sh "The auth page seems to be getting API errors. Investigate how to fix."`).

- If you want to prioritise certain tasks, copy/paste the generated tasks into `todo/next` and use `.scripts/ralph-next.sh`

- If somehow your agents are interrupted mid-task (token limit hit, laptop went to sleep etc), use `.scripts/ralph-continue.sh`.

- _Experimental_ - `.scripts/cleanup.sh` is intended to make QA / refactor / tidy up / audit tasks and execute them.

Very clearly inspired by [ghuntley](https://ghuntley.com/ralph/), [mj1618](https://github.com/mj1618/ralph-demo) and [lizTheDeveloper](https://themultiverse.school/)

## Tips

- This is an exercise in trust. And token usage. ;)

- With prompting, unless you have very clear, specific ideas it is often works best just to describe the outcome that you want, but not how to get there. Let Claude work that out. In general, Claude knows more about most things than you do (but not as much as you do in specific key areas). So rather than say `"Add a button that lets you change the UI to see the mobile view"`, say `"the user should be able to preview on mobile and web views"`. The bot will decide how to make that happen and usually does a pretty good job. If you're too specific, you're telling the AI not to consider alternatives, some of which may be better.

- When you notice that things have gone awry, you have a few options:

1. Create new tasks specifically to fix issues and then run the ralph loop. You can put these tasks into todo/next and use `.scripts/ralph-next.sh` to prioritise them.
2. Delete whatever's not working and rebuild with a different prompt, or after udpating AGENTS.md. Rebuilding is cheap and fast with ralph loops. Code becomes disposable.

- You are going to have to study the cause and effect of your prompts and approaches.

- If you want to do code review, the main things you need to focus on are the architectural decisions and the tests.

- Remember: You're trying to find ways to get the agents to give themselves the right feedback, through tests, docs, AGENTS etc.

## YOLO Mode

If you want to get silly with it AND IF YOU WANT TO BURN TOKENS, after you've completed the [DO THIS FIRST](#do-this-first) stuff, you can unleash the ralphs:

1. In one terminal, do `.scripts/planner-ralph.sh`. This will come up with 20 new feature ideas for your app and build new task files for each one. You can specify the loop count: `.scripts/planner-ralph.md 5`
2. Open up three other terminals. Do `.scripts/ralph.sh` in each.

In this, you have one ralph loop creating new feature tasks, and three ralph loops consuming them and building stuff. Strap yourself in. Leave it running over night. Come back to the chaos in the morning. Expect to need to clean up some stuff, but also expect to have a whole new feature set to explore in your app.
