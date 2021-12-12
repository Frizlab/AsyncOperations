import Foundation



/**
 An operation which is started using `startAsync()`, which is an async function.
 
 An operation is a good abstraction to represent a single piece of work.
 Currently Foundation does not support async `Operation`s (using `async`/`await`, asynchronous operations are otherwise supported, indeed).
 
 This protocol represents an operation that can be started using the new `await` keyboard.
 
 If the AsyncOperation you’re creating is also a Foundation `Operation`, the `start()` function’s implementation should be
 ```swift
 func start() {
    Task{ await startAsync() }
 }
 ```
 or something along these lines.
 
 To be honest I’m not 100% certain this can be useful, but it was an idea I had to try. */
public protocol AsyncOperation {
	
	func startAsync() async
	
}
