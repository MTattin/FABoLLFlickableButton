import XCTest
@testable import FABoLLFlickableButton

final class FABoLLFlickableButtonTests: XCTestCase {

    // MARK: - Static Properties

    static var allTests = [
        ("testAllDirectionsAdd", testAllDirectionsAdd),
    ]

    private static let ButtonSize: CGSize = .init(width: 50, height: 50)

    // MARK: - Properties

    private let base: UIView = .init(frame: UIScreen.main.bounds)

    private let flickableButton: FABoLLFlickableButton = .init(
        frame: CGRect(origin: .zero, size: FABoLLFlickableButtonTests.ButtonSize)
    )

    private var up: UILabel {
        let up: UILabel = .init()
        up.backgroundColor = .brown
        up.textAlignment = .center
        up.textColor = .white
        up.text = "UP"
        return up
    }

    private var down: UILabel {
        let down: UILabel = .init()
        down.backgroundColor = .clear
        down.textAlignment = .center
        down.text = "⚡️"
        return down
    }

    private var left: UILabel {
        let left: UILabel = .init()
        left.backgroundColor = .brown
        left.textAlignment = .center
        left.textColor = .white
        left.text = "Left"
        left.layer.cornerRadius = flickableButton.frame.size.width * 0.5
        return left
    }

    private var right: UILabel {
        let right: UILabel = .init()
        right.backgroundColor = .purple
        right.textAlignment = .center
        right.textColor = .white
        right.text = "✋"
        right.layer.cornerRadius = flickableButton.frame.size.width * 0.5
        return right
    }

    // MARK: - tests

    override func setUp() {
        super.setUp()
        base.addSubview(flickableButton)
        flickableButton.center = base.center
    }

    func testAllDirectionsAdd() {
        flickableButton.setFlickable(
            settings: FABoLLFlickableButtonSettings(
                views: (up: up, left: left, down: down, right: right),
                margins: (up: 10, left: 10, down: 10, right: 10),
                animationDuration: nil
            ),
            callbackUp: nil,
            callbackLeft: nil,
            callbackDown: nil,
            callbackRight: nil
        )
        let titles: [String] = [
            "UP",
            "⚡️",
            "Left",
            "✋",
        ]
        XCTAssertEqual(base.subviews.count, 5)
        base.subviews.forEach { view in
            guard let label = view as? UILabel else { return }
            XCTAssertNotNil(label.text)
            XCTAssertTrue(titles.contains(label.text!))
        }
    }

    func testUpAndDownDirectionsAdd() {
        flickableButton.setFlickable(
            settings: FABoLLFlickableButtonSettings(
                views: (up: up, left: nil, down: down, right: nil),
                margins: (up: 10, left: 10, down: 10, right: 10),
                animationDuration: nil
            ),
            callbackUp: nil,
            callbackLeft: nil,
            callbackDown: nil,
            callbackRight: nil
        )
        let titles: [String] = [
            "UP",
            "⚡️",
        ]
        XCTAssertEqual(base.subviews.count, 3)
        base.subviews.forEach { view in
            guard let label = view as? UILabel else { return }
            XCTAssertNotNil(label.text)
            XCTAssertTrue(titles.contains(label.text!))
        }
    }

    func testLeftAndRightDirectionsAdd() {
        flickableButton.setFlickable(
            settings: FABoLLFlickableButtonSettings(
                views: (up: nil, left: left, down: nil, right: right),
                margins: nil,
                animationDuration: nil
            ),
            callbackUp: nil,
            callbackLeft: nil,
            callbackDown: nil,
            callbackRight: nil
        )
        let titles: [String] = [
            "Left",
            "✋",
        ]
        XCTAssertEqual(base.subviews.count, 3)
        base.subviews.forEach { view in
            guard let label = view as? UILabel else { return }
            XCTAssertNotNil(label.text)
            XCTAssertTrue(titles.contains(label.text!))
        }
    }

    func testAllDirectionsNill() {
        flickableButton.setFlickable(
            settings: FABoLLFlickableButtonSettings(
                views: (up: nil, left: nil, down: nil, right: nil),
                margins: nil,
                animationDuration: nil
            ),
            callbackUp: nil,
            callbackLeft: nil,
            callbackDown: nil,
            callbackRight: nil
        )
        XCTAssertEqual(base.subviews.count, 1)
        base.subviews.forEach { view in
            if let _ = view as? UILabel {
                XCTFail()
            }
        }
    }
}
