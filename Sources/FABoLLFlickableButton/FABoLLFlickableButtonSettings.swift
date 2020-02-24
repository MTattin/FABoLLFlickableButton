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
    // MARK: -------------------- life cycle
    ///
    /// - Important: count should be larger than zero.
    ///
    public init(
        views: (up: UIView?, left: UIView?, down: UIView?, right: UIView?),
        margins: (up: CGFloat, left: CGFloat, down: CGFloat, right: CGFloat)
    ) {
        self.views = views
        self.margins = margins
    }
}
