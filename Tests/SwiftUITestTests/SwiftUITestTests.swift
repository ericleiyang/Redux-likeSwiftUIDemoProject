import XCTest
@testable import SwiftUITest

final class SwiftUITestTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftUITest().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
