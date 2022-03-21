# Mutable Data

Changes to data can often result in unintended consequences and tricky bugs. I may update some data here without realizing that another piece of software expects something different and now fails - a failure that is particularly difficult to locate if it only occurs under rare conditions.

There are a few patterns to apply in this refactoring:

* Encapsulate Variable
* Split Variable
* Slide Statement
* Extract Method
* Separate Query from Modifier
* Remove Setting Method
* Replace Derived Variable with Query
* Combine Method into Class
* Combine Method into Transform
* Change Reference to Value