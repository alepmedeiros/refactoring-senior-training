# Temporary Field

Sometimes you see a class where a field is only defined under certain circumstances. Code like this is hard to understand because you expect an object to need all of its fields. Trying to understand why a field exists when it looks like it's not being used can drive you crazy.

There are a few patterns to apply in this refactoring:

* Extract Class
* Move Function
* Introduce Special Case