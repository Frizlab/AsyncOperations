/* From officectl (an happn-tech project) */

import Foundation

import RetryingOperation



/** Like a BlockOperation, but for asynchronous tasks.
 
 See ``addAsyncBlock(startHandler:)`` in the OperationQueue extension for more information. */
public class AsyncBlockOperation : RetryingOperation {
	
	public typealias StartHandler = (_ stopHandler: @escaping () -> Void) -> Void
	
	public init(startHandler h: @escaping StartHandler) {
		startHandler = h
	}
	
	public init(asyncBlock: @escaping () async -> Void) {
		startHandler = { stopHandler in
			Task{
				await asyncBlock()
				stopHandler()
			}
		}
	}
	
	override public func startBaseOperation(isRetry: Bool) {
		startHandler(baseOperationEnded)
	}
	
	override public var isAsynchronous: Bool {
		return true
	}
	
	private let startHandler: StartHandler
	
}


public extension OperationQueue {
	
	/**
	 Add an AsyncBlockOperation to the queue, directly with a block.
	 
	 Here’s how it works:
	 - The operation starts, calling the block you give in argument.
	 You should start your your work there.
	 You can start an async work, indeed.
	 - When your block is called, it is given another block (the stop handler).
	 You have to call this stop handler when your work is done (whether it ended synchronously or asynchronously).
	 
	 TODO: Should we support cancellation?
	 
	 - parameter startHandler: The handler that starts your work. */
	func addAsyncBlock(startHandler: @escaping AsyncBlockOperation.StartHandler) {
		addOperation(AsyncBlockOperation(startHandler: startHandler))
	}
	
	func addAsyncBlock(_ block: @escaping () async -> Void) {
		addOperation(AsyncBlockOperation(asyncBlock: block))
	}
	
}
