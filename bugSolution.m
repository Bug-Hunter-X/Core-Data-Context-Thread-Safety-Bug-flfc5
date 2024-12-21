To address this issue, use `NSManagedObjectContext`'s concurrency features.  Create a separate context for background threads and use `performBlock:` or `performBlockAndWait:` to ensure operations happen on the correct thread.  Here's how to modify the code to be thread-safe:

```objectivec
// Correct - Using performBlock on the correct context
NSManagedObjectContext *privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
[privateContext setParentContext:mainContext]; // mainContext is your main context

dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ 
    [privateContext performBlock:^{ 
        NSError *error = nil;
        if (![privateContext save:&error]) {
            NSLog("Error saving private context: %@
", error);
        }
    }];
});

// Main thread operations
[mainContext performBlock:^{ 
  // Save the main context when appropriate 
  NSError *error = nil; 
  if (![mainContext save:&error]) { 
    NSLog("Error saving main context: %@
", error); 
  } 
}];
```
This solution ensures that all Core Data operations are performed on the appropriate thread, preventing crashes and maintaining data integrity.