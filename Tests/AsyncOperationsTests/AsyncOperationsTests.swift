import XCTest

@testable import AsyncOperations



final class AsyncOperationsTests : XCTestCase {
	
	func testBasicAsyncTask() throws {
		let startDate = Date()
		let queue = OperationQueue()
		queue.addAsyncBlock{
			try? await Task.sleep(nanoseconds: 1_000_000_000)
		}
		queue.waitUntilAllOperationsAreFinished()
		XCTAssertLessThanOrEqual(startDate.timeIntervalSinceNow, -1)
	}
	
}
