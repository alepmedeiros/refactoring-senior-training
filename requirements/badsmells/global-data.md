# Global Data

Ever since we started writing software, we've been warned of the dangers of global data. The problem with global data is that it can be modified anywhere in the codebase, and there is no blueprint for figuring out which part of the code made the change.

There are a few patterns to apply in this refactoring:

* Encapsulate Variable.