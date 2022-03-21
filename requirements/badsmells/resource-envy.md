# Resource Envy

When we modularize a program, we are trying to separate the code into zones to maximize interaction within a zone and minimize interaction between different zones. A classic case of Resource Envy occurs when a function in one module spends more time communicating with functions or data in another module than with the module itself.

There are a few patterns to apply in this refactoring:

* Move Method
* Extract Method