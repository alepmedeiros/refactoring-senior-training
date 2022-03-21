> ### Making a Local Clone

Even though you have a copy of the original repository in your GitHub account, you don’t yet have a way to make changes to your copy of the repository. For that you will have to run the command git clone.

Before you can run git clone, though, you need to determine the URL for the forked repository. That’s pretty simple: just navigate to the forked repository (this is the copy of the original repository residing in your GitHub account) and look on the right-hand side of the web page. You should see an area that is labeled “HTTPS clone URL”. Simple copy the URL there, and then use it with git clone like this (this is the command you will perform to clone this repository):

```bash
git clone https://github.com/[your user]/refactoring-senior-training.git
```