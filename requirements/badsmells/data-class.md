# Data Class

These are the classes that have fields, read and write methods for the fields, and nothing else. Classes of this type are dumb data stores and are often handled in excessive detail by other classes. In some stages, these classes may have public fields.

There are a few patterns to apply in this refactoring:

* Encapsulate Record
* Remove Setting Method
* Move Function
* Extract Function
* Split Phase