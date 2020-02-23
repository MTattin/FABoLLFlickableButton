import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FlickableButtonTests.allTests),
    ]
}
#endif
