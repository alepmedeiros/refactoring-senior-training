> ### Adding a Remote

Git already added a Git remote named origin to the clone of the Git repository on your system, and this will allow you to push changes back up to the forked repository in your GitHub account using git commit (to add commits locally) and git push.

To use the “fork and branch” workflow, you’ll need to add a Git remote pointing back to the original repository (the one you forked on GitHub). You can call this Git remote anything you want; most documents and guides I’ve read recommend using the term “upstream”. You who forked this repository will do it like this:

```bash
git remote add upstream https://github.com/alepmedeiros/refactoring-senior-training.git
```
