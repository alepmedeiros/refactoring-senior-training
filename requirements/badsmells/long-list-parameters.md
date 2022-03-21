# Long List of Parameters

When we developed we were tempted, or even, we followed what we learned a long time ago, to pass everything necessary to a method as a parameter. This was understandable, as the alternative would be to use global data, and global data quickly becomes a threat. However, long parameter lists are often confusing in their own right.

There are a few patterns to apply in this refactoring:

* Replace Parameter with Query
* Preserve Whole Object
* Introduce Parameter Object
* Remove Flag Argument
* Combine Functions into Class