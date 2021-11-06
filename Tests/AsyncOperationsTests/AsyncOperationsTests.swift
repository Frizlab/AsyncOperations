import XCTest

@testable import AsyncOperations



final class AsyncOperationsTests : XCTestCase {
	
	func testBasicAsyncTask() async throws {
		let startDate = Date()
		let queue = OperationQueue()
		queue.addAsyncBlock{
			await withCheckedContinuation{ continuation in
				DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1), execute: {
					continuation.resume()
				})
			}
		}
		queue.waitUntilAllOperationsAreFinished()
		XCTAssertLessThanOrEqual(startDate.timeIntervalSinceNow, -1)
	}
	
}
