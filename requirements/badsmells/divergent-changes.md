# Divergent Changes

We structure our software to facilitate changes; after all, software must be soft. When we make a change, we want to be able to directly access a single clear point in the system and make that change. If you can't do that, it's a sign that you're sensing two closely related pungent smells.

There are a few patterns to apply in this refactoring:

* Split Phase
* Move Method
* Extract Method
* Extract Class