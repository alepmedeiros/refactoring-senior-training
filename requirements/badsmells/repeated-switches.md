# Repeated Switches

Talk to a true object-oriented evangelist, and these people will soon talk about the evils of switch statements. They'll argue that any switch statement you see is begging to be conditionally replaced by polymorphism, and I dare say, an entire conditional logic could be replaced by polymorphism, throwing most ifs into the dustbin of history.

There are a few patterns to apply in this refactoring:

* Replace Conditional with Polymorphism