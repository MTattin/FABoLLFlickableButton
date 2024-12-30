//
//  FABoLLFlickableButtonTest
//
//  © 2023 Masakiyo Tachikawa
//

import Testing
import XCTest
@testable import FABoLLFlickableButton

@MainActor
struct FABoLLFlickableButtonTest {

    private let base: UIView = .init(frame: UIScreen.main.bounds)
    private let flickableButton: FABoLLFlickableButton = .init(
        frame: CGRect(
            origin: .zero,
            size: .init(width: 50, height: 50)
        )
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


    @Test func test() async throws {
        base.addSubview(flickableButton)
        flickableButton.center = base.center
        var settings: FABoLLFlickableButtonSettings = .init(
            upView: up,
            leftView: left,
            downView: down,
            rightView: right,
            upMargin: 10,
            leftMargin: 10,
            downMargin: 10,
            rightMargin: 10
        )
        // All
        flickableButton.setFlickable(settings: settings)
        var titles: [String] = [
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
        // Up and Down
        settings.update(\.leftView, nil)
        settings.update(\.rightView, nil)
        flickableButton.setFlickable(settings: settings)
        titles = [
            "UP",
            "⚡️",
        ]
        XCTAssertEqual(base.subviews.count, 3)
        base.subviews.forEach { view in
            guard let label = view as? UILabel else { return }
            XCTAssertNotNil(label.text)
            XCTAssertTrue(titles.contains(label.text!))
        }
        // Left and Right
        settings.update(\.upView, nil)
        settings.update(\.downView, nil)
        settings.update(\.leftView, left)
        settings.update(\.rightView, right)
        flickableButton.setFlickable(settings: settings)
        titles = [
            "Left",
            "✋",
        ]
        XCTAssertEqual(base.subviews.count, 3)
        base.subviews.forEach { view in
            guard let label = view as? UILabel else { return }
            XCTAssertNotNil(label.text)
            XCTAssertTrue(titles.contains(label.text!))
        }
        // None
        settings.update(\.leftView, nil)
        settings.update(\.rightView, nil)
        flickableButton.setFlickable(settings: settings)
        XCTAssertEqual(base.subviews.count, 1)
        base.subviews.forEach { view in
            if let _ = view as? UILabel {
                XCTFail()
            }
        }
    }
}
