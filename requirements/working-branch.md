![alt_text](./public/git-branches-merge.png)

---

> ### Working in a Branch

So far, you’ve forked a project repository, cloned it down to your local system, and added a Git remote to your clone that points to the original project repository on GitHub. Now you’re ready to start making changes to your local Git repository. To effectively collaborate with others on the same repo, you should use a branch.

And so that you can proceed with the refactoring contributions to the project, and create pull requests, it is necessary to work with the branches.

1. Create and checkout a branch(preferably called develop).
2. Make changes to the files.
3. Commit your changes to the branch.

To create a new branch and check it out (meaning tell Git you will be making changes to the branch), use this command:

```bash
git checkout -b <new branch name>
```
As you make changes to the files in the branch, you’ll want to commit those changes, building your changeset with git add and committing the changes using git commit.