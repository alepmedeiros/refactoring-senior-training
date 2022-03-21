# Message Strings

We see message chains when a client requests an object for another object, whose client then requests another object, whose client then requests another object, and so on. You can see this as a long line of getThis methods, or as a string of temporary variables. Navigating this way means that the client is coupled to the navigation framework. Any change in intermediary relationships will cause the customer to change.

There are a few patterns to apply in this refactoring:

* Hide Delegate
* Extract Function
* Move Function