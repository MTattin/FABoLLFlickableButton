//
//  FABoLLFlickableButtonSettings
//
//  © 2023 Masakiyo Tachikawa
//

import UIKit

// MARK: - FABoLLFlickableButtonSettings

public struct FABoLLFlickableButtonSettings {

    // MARK: - Properties

    /// Display view when flicked
    let views: (up: UIView?, left: UIView?, down: UIView?, right: UIView?)
    ///  Margin between base view and flicked view
    let margins: (up: CGFloat, left: CGFloat, down: CGFloat, right: CGFloat)

    let animationDuration: (show: Double, stay: Double, hide: Double)

    // MARK: - Life cycle

    public init(
        views: (up: UIView?, left: UIView?, down: UIView?, right: UIView?),
        margins: (up: CGFloat, left: CGFloat, down: CGFloat, right: CGFloat)?,
        animationDuration: (show: Double, stay: Double, hide: Double)?
    ) {
        self.views = views
        if let margins {
            self.margins = margins
        } else {
            self.margins = (up: 0, left: 0, down: 0, right: 0)
        }
        if let animationDuration {
            self.animationDuration = animationDuration
        } else {
            self.animationDuration = (show: 0.1, stay: 0.5, hide: 0.1)
        }
    }
}
