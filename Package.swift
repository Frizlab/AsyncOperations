// swift-tools-version:5.5
import PackageDescription


let package = Package(
	name: "AsyncOperations",
	platforms: [.macOS(.v12), .iOS(.v15), .tvOS(.v15), .watchOS(.v8)],
	products: [.library(name: "AsyncOperations", targets: ["AsyncOperations"])],
	dependencies: [
		.package(url: "https://github.com/happn-app/RetryingOperation.git", from: "1.1.7")
	],
	targets: [
		.target(name: "AsyncOperations", dependencies: [
			.product(name: "RetryingOperation", package: "RetryingOperation")
		]),
		.testTarget(name: "AsyncOperationsTests", dependencies: ["AsyncOperations"])
	]
)
