//
//  FABoLLFlickableButtonSettings
//
//  © 2023 Masakiyo Tachikawa
//

import UIKit

// MARK: - FABoLLFlickableButtonSettings

public struct FABoLLFlickableButtonSettings: Sendable {

    // MARK: - Properties

    public private(set) var upView: UIView?
    public private(set) var leftView: UIView?
    public private(set) var downView: UIView?
    public private(set) var rightView: UIView?

    public private(set) var upMargin: CGFloat
    public private(set) var leftMargin: CGFloat
    public private(set) var downMargin: CGFloat
    public private(set) var rightMargin: CGFloat

    public private(set) var showDuration: Double
    public private(set) var stayDuration: Double
    public private(set) var hideDuration: Double

    // MARK: - Life cycle

    public init(
        upView: UIView? = nil,
        leftView: UIView? = nil,
        downView: UIView? = nil,
        rightView: UIView? = nil,
        upMargin: CGFloat = 10,
        leftMargin: CGFloat = 10,
        downMargin: CGFloat = 10,
        rightMargin: CGFloat = 10,
        showDuration: Double = 0.1,
        stayDuration: Double = 0.5,
        hideDuration: Double = 0.1
    ) {
        self.upView = upView
        self.leftView = leftView
        self.downView = downView
        self.rightView = rightView
        self.upMargin = upMargin
        self.leftMargin = leftMargin
        self.downMargin = downMargin
        self.rightMargin = rightMargin
        self.showDuration = showDuration
        self.stayDuration = stayDuration
        self.hideDuration = hideDuration
    }

    public mutating func update<T>(_ key: KeyPath<Self, T>, _ value: T) {
        guard let writableKey = key as? WritableKeyPath<Self, T> else {
            assertionFailure("KeyPath変換で問題発生")
            return
        }
        self[keyPath: writableKey] = value
    }
}
