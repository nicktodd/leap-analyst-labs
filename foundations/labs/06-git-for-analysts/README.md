# Lab 06: Branch, commit, review and merge

## Objectives

- Work on a feature branch named after a JIRA story, with one commit per logical change.
- Push a branch, open a pull request (PR), and review a teammate's PR line by line.
- Resolve a merge conflict as a content decision.
- Read a file's history with `git log`, `git blame` and `git show`.

## Setup

Time: 45 minutes, teams (Part A). Part B is finished in end-of-week project time.

1. Your instructor has created a team repository and copied the contents of `starter/` into
   it. It holds `docs/glossary.md` and `docs/briefing-pack-summary.md`.
2. Configure Git once on your laptop (see the One-Time Setup slide), then clone the team
   repository and open it in VS Code:

   ```
   git clone <team-repo-url>
   cd <team-repo-folder>
   ```

3. Pick one JIRA story from your Module 05 backlog. Its key names your branch.

If Git cannot reach GitHub from your laptop, use the website: create the branch from the branch
menu, edit the file with the pencil icon, and commit each change separately.

## Tasks

### Part A: glossary (individual work in a shared repository)

1. Start from an up-to-date `main` and create your branch:

   ```
   git switch main
   git pull
   git switch -c feature/<JIRA-key>-glossary
   ```

2. Add three terms to the table in `docs/glossary.md`, taken from the BRS (Business
   Requirements Specification). Choose terms not already listed. Give each a one-line
   definition and its BR reference.
3. Make **three separate commits**, one per term. Run `git status` and `git diff` before each
   commit. Messages start with a verb, for example `Add 'quote' with BR-13 source`.
4. Push the branch (`git push -u origin <branch>`) and open a pull request on GitHub. The
   description says which JIRA story it relates to.
5. Review one teammate's PR: read every changed line in Files changed, check each definition
   against the BRS, and leave at least one comment on a specific line.
6. Respond to the review on your own PR with another commit, push, then merge once approved.
7. If Git reports a conflict (two people added a row in the same place), keep both rows unless
   they define the same term; agree the wording as a team, delete the markers, commit.
8. Switch back to `main`, pull, delete your branch (`git branch -d <branch>`), then run
   `git log --oneline -- docs/glossary.md` and `git blame docs/glossary.md`.

### Part B: briefing pack summary (team)

1. Complete `06-Git-ScenarioBriefingPack.docx` from the course docs folder.
2. Copy sections 1, 3 and 7 into `docs/briefing-pack-summary.md` in the team repository
   (plain text, keep the headings).
3. Submit it on a branch through a PR; a teammate who did not write it approves before merge.

## Acceptance criteria

- Each person's branch is named `feature/<JIRA-key>-...` and contains three term commits with
  clear messages.
- Every PR has at least one review comment on a specific line and was merged after approval.
- `docs/glossary.md` on `main` has every team member's terms, each with a BR reference, and no
  conflict markers.
- Merged branches are deleted.
- `docs/briefing-pack-summary.md` is on `main`, merged through a reviewed PR.

## Stretch

- Use `git show <id>` on a teammate's commit and explain in one sentence what it changed.
- Find the commit that introduced a term you disagree with, and raise the question as a JIRA
  comment on the related story.

## Apply it to your project

Use this workflow for every analysis artefact you add to the team repository from now on: a branch named after the JIRA story, small commits, a pull request reviewed by a teammate. Agree with the engineers where analysis artefacts live in the repository (for example `analysis/`) and record it in the ways-of-working agreement.
