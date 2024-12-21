In Objective-C, a common yet subtle error arises when dealing with `NSManagedObjectContext` and its interaction with threads.  Specifically, attempting to perform operations on an `NSManagedObjectContext` from a thread other than the one it was created on can lead to unexpected crashes or data corruption.  This is because Core Data's context isn't thread-safe. 

```objectivec
// Incorrect - Accessing the context from a background thread
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ 
    [context save:nil]; // Crash or data corruption likely
});
```