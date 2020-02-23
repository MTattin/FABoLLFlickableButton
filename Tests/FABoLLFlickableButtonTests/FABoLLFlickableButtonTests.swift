import XCTest
@testable import FABoLLFlickableButton
///
/// - Tag: FlickableButtonTests
///
final class FlickableButtonTests: XCTestCase {
    ///
    // MARK: -------------------- static properties
    ///
    ///
    ///
    static var allTests = [
        ("testExample", testExample),
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
    private let _flickableButton: FlickableButton = FlickableButton.init(
        frame: CGRect.init(
            origin: CGPoint.zero,
            size: FlickableButtonTests._ButtonSize
        )
    )
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
    func testAddSubviews() {
        let up: UILabel = UILabel.init()
        up.backgroundColor = UIColor.brown
        up.textAlignment = NSTextAlignment.center
        up.textColor = UIColor.white
        up.text = "UP"
        let down: UILabel = UILabel.init()
        down.backgroundColor = UIColor.clear
        down.textAlignment = NSTextAlignment.center
        down.text = "⚡️"
        let left: UILabel = UILabel.init()
        left.backgroundColor = UIColor.brown
        left.textAlignment = NSTextAlignment.center
        left.textColor = UIColor.white
        left.text = "Left"
        left.layer.cornerRadius = self._flickableButton.frame.size.width * 0.5
        let right: UILabel = UILabel.init()
        right.backgroundColor = UIColor.purple
        right.textAlignment = NSTextAlignment.center
        right.textColor = UIColor.white
        right.text = "✋"
        right.layer.cornerRadius = self._flickableButton.frame.size.width * 0.5
        self._flickableButton.setFlickable(
            settings: FlickableButtonSettings.init(
                views: (
                    up: up,
                    left: left,
                    down: down,
                    right: right
                ),
                margins: (
                    up: 10.0,
                    left: 10.0,
                    down: 10.0,
                    right: 10.0
                )
            ),
            callbackUp: {
            },
            callbackLeft: {
            },
            callbackDown: {
            },
            callbackRight: {
            }
        )
        XCTAssertEqual(self._base.subviews.count, 5)
        let titles: [String] = [
            "UP",
            "⚡️",
            "Left",
            "✋",
        ]
        XCTAssertNotNil(
            self._base.subviews.filter({ (view: UIView) -> Bool in
                guard let label: UILabel = view as? UILabel else {
                    return false
                }
                return titles.contains(label.text ?? "")
            })
        )
    }
}
