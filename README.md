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
Unleash the ralphs! To begin with, maybe build 3 features out to see where they're going right, and where they need assistance.

Test / Document:
You then need a stopping point to get feedback on how it's going. Look at the tests they're writing, and consider them against your understanding of the desired project outcomes.

The most important things you need to be aware is the intended architecture and outcomes of the app, and whether or not the tests safeguard those outcomes. The tests must give good feedback to new agents, and have the reason behind the tests documented as comments at the beginning of the test file.

## Init

Run `.scripts/init.sh` to make folders.

1. Have a chat with an agent about your app idea. Discuss architecture and tech choices.
2. Once you're satisfied that it has a deep understanding of your vision, tell it:

> I need you to plan this application to build. Have phases where the important features are done in the first phase and so on. Include tests of functionality, but don't focus on it too much. Never include time estimations or time considerations - instead, think in dependency chains. Write this out to plans/plan.md.

3. Once that's done, say the following:

> Study plans/plan.md. Come up with a list of features ordered by importance. Break these down into more manageable 'tasks' that will likely fit in a single agent context window. Write the broken down tasks into /todo/{feature-name}/{task-name}.pending.md

4. (optional): If you have a particular ideas on project structure, create an example structure in examples/

5. Finally, do `.scripts/ralph.sh` or `.scripts/ralph.sh 3` for only three iterations (~3 tasks).

## Guide

After you've created your app plan and prepared the initial tasks, and had ralph loop over it, here are things you can try.

- Use `.scripts/planner.sh` to create new features based on the plan. It will decide what to come up with. Its ideas are often surprisingly good. You can leave the planner running to generate features/task files, while other ralphs are consuming them and building.

- Correct them by updating AGENTS.md, by updating the scripts, or by adding new tasks (ie).

- If you want to add specific tasks, use the `task-planner` agent to help.

- If you want to prioritise certain tasks, copy/paste the generated tasks into `todo/next` and use `.scripts/ralph-next`

- If somehow your agents are interrupted mid-task (token limit hit, laptop went to sleep etc), use `ralph-continue.sh`.

- _Experimental_ - `.scripts/cleanup.sh` is intended to make QA / refactor / tidy up / audit tasks and execute them. But I haven't tried it yet because I ran out of tokens this week :D Try it out. Let me know if it works. ;)

Very clearly inspired by [ghuntley](https://ghuntley.com/ralph/) and [mj1618](https://github.com/mj1618/ralph-demo)
