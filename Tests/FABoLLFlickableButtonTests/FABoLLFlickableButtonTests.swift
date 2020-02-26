import XCTest
@testable import FABoLLFlickableButton
///
/// - Tag: FABoLLFlickableButtonTests
///
final class FABoLLFlickableButtonTests: XCTestCase {
    ///
    // MARK: -------------------- static properties
    ///
    ///
    ///
    static var allTests = [
        ("testAllDirectionsAdd", testAllDirectionsAdd),
    ]
    ///
    ///
    ///
    private static let _ButtonSize: CGSize = CGSize.init(width: 50, height: 50)
    ///
    // MARK: -------------------- properties
    ///
    ///
    ///
    private let _base: UIView = UIView.init(frame: UIScreen.main.bounds)
    private let _flickableButton: FABoLLFlickableButton = FABoLLFlickableButton.init(
        frame: CGRect.init(
            origin: CGPoint.zero,
            size: FABoLLFlickableButtonTests._ButtonSize
        )
    )
    ///
    ///
    ///
    private var _up: UILabel {
        let up: UILabel = UILabel.init()
        up.backgroundColor = UIColor.brown
        up.textAlignment = NSTextAlignment.center
        up.textColor = UIColor.white
        up.text = "UP"
        return up
    }
    private var _down: UILabel {
        let down: UILabel = UILabel.init()
        down.backgroundColor = UIColor.clear
        down.textAlignment = NSTextAlignment.center
        down.text = "⚡️"
        return down
    }
    private var _left: UILabel {
        let left: UILabel = UILabel.init()
        left.backgroundColor = UIColor.brown
        left.textAlignment = NSTextAlignment.center
        left.textColor = UIColor.white
        left.text = "Left"
        left.layer.cornerRadius = self._flickableButton.frame.size.width * 0.5
        return left
    }
    private var _right: UILabel {
        let right: UILabel = UILabel.init()
        right.backgroundColor = UIColor.purple
        right.textAlignment = NSTextAlignment.center
        right.textColor = UIColor.white
        right.text = "✋"
        right.layer.cornerRadius = self._flickableButton.frame.size.width * 0.5
        return right
    }
    ///
    // MARK: -------------------- tests
    ///
    ///
    ///
    override func setUp() {
        super.setUp()
        self._base.addSubview(self._flickableButton)
        self._flickableButton.center = self._base.center
    }
    ///
    ///
    ///
    func testAllDirectionsAdd() {
        self._flickableButton.setFlickable(
            settings: FABoLLFlickableButtonSettings.init(
                views: (
                    up: self._up,
                    left: self._left,
                    down: self._down,
                    right: self._right
                ),
                margins: (
                    up: 10.0,
                    left: 10.0,
                    down: 10.0,
                    right: 10.0
                ),
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
        XCTAssertEqual(self._base.subviews.count, 5)
        self._base.subviews.forEach { (view: UIView) in
            guard let label: UILabel = view as? UILabel else {
                return
            }
            XCTAssertNotNil(label.text)
            XCTAssertTrue(titles.contains(label.text!))
        }
    }
    ///
    ///
    ///
    func testUpAndDownDirectionsAdd() {
        self._flickableButton.setFlickable(
            settings: FABoLLFlickableButtonSettings.init(
                views: (
                    up: self._up,
                    left: nil,
                    down: self._down,
                    right: nil
                ),
                margins: (
                    up: 10.0,
                    left: 10.0,
                    down: 10.0,
                    right: 10.0
                ),
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
        XCTAssertEqual(self._base.subviews.count, 3)
        self._base.subviews.forEach { (view: UIView) in
            guard let label: UILabel = view as? UILabel else {
                return
            }
            XCTAssertNotNil(label.text)
            XCTAssertTrue(titles.contains(label.text!))
        }
    }
    ///
    ///
    ///
    func testLeftAndRightDirectionsAdd() {
        self._flickableButton.setFlickable(
            settings: FABoLLFlickableButtonSettings.init(
                views: (
                    up: nil,
                    left: self._left,
                    down: nil,
                    right: self._right
                ),
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
        XCTAssertEqual(self._base.subviews.count, 3)
        self._base.subviews.forEach { (view: UIView) in
            guard let label: UILabel = view as? UILabel else {
                return
            }
            XCTAssertNotNil(label.text)
            XCTAssertTrue(titles.contains(label.text!))
        }
    }
    ///
    ///
    ///
    func testAllDirectionsNill() {
        self._flickableButton.setFlickable(
            settings: FABoLLFlickableButtonSettings.init(
                views: (
                    up: nil,
                    left: nil,
                    down: nil,
                    right: nil
                ),
                margins: nil,
                animationDuration: nil
            ),
            callbackUp: nil,
            callbackLeft: nil,
            callbackDown: nil,
            callbackRight: nil
        )
        XCTAssertEqual(self._base.subviews.count, 1)
        self._base.subviews.forEach { (view: UIView) in
            if let _: UILabel = view as? UILabel {
                XCTFail()
            }
        }
    }
}
