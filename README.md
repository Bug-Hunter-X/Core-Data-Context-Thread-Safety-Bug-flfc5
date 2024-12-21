# Objective-C Core Data Concurrency Bug
This repository demonstrates a common error in Objective-C Core Data programming: accessing an `NSManagedObjectContext` from an incorrect thread.  The `bug.m` file shows the problematic code, which attempts to save the context from a background thread. This leads to crashes or data inconsistencies.  The solution, provided in `bugSolution.m`, illustrates the correct approach using Core Data's concurrency features.