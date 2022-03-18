![alt_text](./public/refactoring-design-code.png)

---

> ### Keeping Your Fork in Sync

Your forked repository doesn’t automatically stay in sync with the original repository; you need to take care of this yourself. After all, in a healthy open source project, multiple contributors are forking the repository, cloning it, creating feature branches, committing changes, and submitting pull requests.

To keep your fork in sync with the original repository, use these commands:

```bash
git pull upstream master
git push origin master
```

This pulls the changes from the original repository (the one pointed to by the upstream Git remote) and pushes them to your forked repository (the one pointed to by the origin remote).