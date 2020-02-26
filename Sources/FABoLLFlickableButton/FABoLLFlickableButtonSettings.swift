//
//  FABoLLFlickableButtonSettings.swift
//  
//
//  Created by Masakiyo Tachikawa on 2020/02/22.
//
import UIKit
///
/// - Tag: FABoLLFlickableButtonSettings
///
public struct FABoLLFlickableButtonSettings {
    ///
    // MARK: -------------------- properties
    ///
    /// Display view when flicked
    ///
    let views: (up: UIView?, left: UIView?, down: UIView?, right: UIView?)
    ///
    ///  Margin between base view and flicked view
    ///
    let margins: (up: CGFloat, left: CGFloat, down: CGFloat, right: CGFloat)
    ///
    ///
    ///
    let animationDuration: (show: Double, stay: Double, hide: Double)
    ///
    // MARK: -------------------- life cycle
    ///
    /// margins default is (up: 0.0, left: 0.0, down: 0.0, right: 0.0)?
    ///
    /// animationDuration default is (show: 0.1, stay: 0.5, hide: 0.1)
    ///
    public init(
        views: (up: UIView?, left: UIView?, down: UIView?, right: UIView?),
        margins: (up: CGFloat, left: CGFloat, down: CGFloat, right: CGFloat)?,
        animationDuration: (show: Double, stay: Double, hide: Double)?
    ) {
        self.views = views
        if let margins = margins {
            self.margins = margins
        } else {
            self.margins = (
                up: 0.0,
                left: 0.0,
                down: 0.0,
                right: 0.0
            )
        }
        if let animationDuration = animationDuration {
            self.animationDuration = animationDuration
        } else {
            self.animationDuration = (
                show: 0.1,
                stay: 0.5,
                hide: 0.1
            )
        }
    }
}
