> ### Cleaning up After a Merged Pull Request

With your contributions accepted and merged into the main repository, there will be a bit of cleanup for you to do. First, you must update your local clone using git pull upstream master. This pulls changes from the upstream branch master from the original repository to the local cloned repository. One of the commits in the commit history will be the commit that merged your branch, so after you git pull your local repository’s master branch will have your branch’s changes committed. This means you can delete the branch:

```bash
git branch -d <branch name>
```

Then you can update the master branch in your forked repository:

```bash
git push origin master
```

And push the deletion of the feature branch to your GitHub repository:

```bash
git push -d origin <branch name>
```

