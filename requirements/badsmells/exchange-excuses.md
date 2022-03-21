# Exchange Excuses

People who work with software like strong walls between their modules and complain a lot about how many data exchanges increase coupling. For a system to work, some tradeoffs have to take place, but we need to keep them to a minimum and keep them clear.

There are a few patterns to apply in this refactoring:

* Move Function
* Move Field
* Hide Delegate
* Replace Subclass with Delegate
* Replace Superclass with Delegate