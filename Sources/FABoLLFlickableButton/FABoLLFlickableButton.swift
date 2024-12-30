//
//  FABoLLFlickableButton
//
//  © 2023 Masakiyo Tachikawa
//

import UIKit

public class FABoLLFlickableButton: UIButton {

    // MARK: - typealias

    private typealias FlickableView = (view: UIView?, center: CGPoint, callback: (() -> Void)?)

    // MARK: - Properties

    private var settings: FABoLLFlickableButtonSettings = .init()
    private var panStart: CGPoint = .zero

    private var callbackUp: (() -> Void)?
    private var callbackLeft: (() -> Void)?
    private var callbackDown: (() -> Void)?
    private var callbackRight: (() -> Void)?

    private var upView: UIView? { settings.upView }
    private var leftView: UIView? { settings.leftView }
    private var downView: UIView? { settings.downView }
    private var rightView: UIView? { settings.rightView }
    private var upCenter: CGPoint { .init(x: center.x, y: center.y - frame.height - settings.upMargin) }
    private var leftCenter: CGPoint { .init(x: center.x - frame.width - settings.leftMargin, y: center.y) }
    private var downCenter: CGPoint { .init(x: center.x, y: center.y + frame.height + settings.downMargin) }
    private var rightCenter: CGPoint { .init(x: center.x + frame.width + settings.rightMargin, y: center.y) }
    private var showDuration: Double { settings.showDuration }
    private var hideDuration: Double { settings.hideDuration }
    private var stayDuration: Double { settings.stayDuration }

    // MARK: - Conveniences

    private func getTarget(_ direction: FABoLLFlickableButton.PanDirection) -> FlickableView {
        switch direction {
        case .none:
            (nil, center, nil)
        case .up:
            (upView, upCenter, callbackUp)
        case .left:
            (leftView, leftCenter, callbackLeft)
        case .down:
            (downView, downCenter, callbackDown)
        case .right:
            (rightView, rightCenter, callbackRight)
        }
    }

    // MARK: - Life cycle

    deinit {
        print("FlickableButton released")
    }

    /// `settings` define is FABoLLFlickableButtonSettings.
    public func setFlickable(
        settings: FABoLLFlickableButtonSettings,
        callbackUp: (() -> Void)? = nil,
        callbackLeft: (() -> Void)? = nil,
        callbackDown: (() -> Void)? = nil,
        callbackRight: (() -> Void)? = nil
    ) {
        self.settings = settings
        self.callbackUp = callbackUp
        self.callbackLeft = callbackLeft
        self.callbackDown = callbackDown
        self.callbackRight = callbackRight
        setViews()
        setGesture()
    }

    private func setViews() {
        [
            upView,
            leftView,
            downView,
            rightView,
        ].forEach { view in
            guard let view else { return }
            view.isUserInteractionEnabled = false
            view.alpha = 0
            superview?.addSubview(view)
        }
    }

    private func setGesture() {
        [
            UISwipeGestureRecognizer.Direction.up,
            UISwipeGestureRecognizer.Direction.left,
            UISwipeGestureRecognizer.Direction.down,
            UISwipeGestureRecognizer.Direction.right,
        ].forEach { direction in
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
            swipe.direction = direction
            addGestureRecognizer(swipe)
        }

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        longPress.minimumPressDuration = 0.5
        addGestureRecognizer(longPress)
    }

    // MARK: - Swipe

    @objc private func swiped(_ gesture: UISwipeGestureRecognizer) {
        let direction: FABoLLFlickableButton.PanDirection = gesture.direction.panDirection
        if direction == .none { return }
        let target: FlickableView = getTarget(direction)
        showFlickableView(target.view, target.center)
        target.callback?()
    }

    private func showFlickableView(_ view: UIView?, _ center: CGPoint) {
        guard let view else { return }
        view.frame.size = frame.size
        view.center = center
        clipsToBounds = false
        UIView.animate(withDuration: showDuration) {
            view.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: self.hideDuration, delay: self.stayDuration, options: .curveEaseIn) {
                view.alpha = 0
            } completion: { _ in
                self.clipsToBounds = true
            }
        }
    }

    // MARK: - Long press

    @objc private func longPressed(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            clipsToBounds = false
            showAndHideAllFlickableViews(isHidden: false)
            panStart = gesture.location(in: self)
            return
        }
        if gesture.state == .changed {
            let point: CGPoint = gesture.location(in: self)
            let direction: FABoLLFlickableButton.PanDirection = getPanDirection(point)
            if direction == .none { return }
            panShowFlickableView(direction)
            return
        }
        let point: CGPoint = gesture.location(in: self)
        let direction: FABoLLFlickableButton.PanDirection = getPanDirection(point)
        if direction == .none {
            hideAllFlickableView()
        } else {
            panExecuteFlickableView(direction)
        }
    }

    private func showAndHideAllFlickableViews(isHidden: Bool) {
        alpha = isHidden ? 1 : 0.5
        FABoLLFlickableButton.PanDirection.allCases.forEach { direction in
            let target: FlickableView = getTarget(direction)
            target.view?.frame.size = frame.size
            target.view?.center = target.center
            target.view?.alpha = isHidden ? 0 : 1
        }
    }

    private func getPanDirection(_ point: CGPoint) -> FABoLLFlickableButton.PanDirection {
        if abs(point.x - panStart.x) < frame.width * 0.5 && abs(point.y - panStart.y) < frame.height * 0.5 {
            return .none
        }
        let diffX: CGFloat = point.x - panStart.x
        let diffY: CGFloat = point.y - panStart.y
        if abs(diffX) < abs(diffY) {
            return (diffY < 0) ? .up : .down
        } else {
            return (diffX < 0) ? .left : .right
        }
    }
    /// Hide all Flickable views except target (parameter `to`)
    private func panShowFlickableView(_ to: FABoLLFlickableButton.PanDirection) {
        FABoLLFlickableButton.PanDirection.allCases
            .filter { $0 != to }
            .forEach { getTarget($0).view?.alpha = 0 }
    }

    private func hideAllFlickableView() {
        UIView.animate(withDuration: hideDuration, delay: stayDuration, options: .curveEaseIn) {
            self.alpha = 1
            self.upView?.alpha = 0
            self.leftView?.alpha = 0
            self.downView?.alpha = 0
            self.rightView?.alpha = 0
        } completion: { _ in
            self.clipsToBounds = true
        }
    }

    private func panExecuteFlickableView(_ direction: FABoLLFlickableButton.PanDirection) {
        alpha = 1
        UIView.animate(withDuration: hideDuration, delay: stayDuration, options: .curveEaseIn) {
            self.getTarget(direction).view?.alpha = 0
        } completion: { _ in
            self.clipsToBounds = true
        }
        getTarget(direction).callback?()
    }
}

private extension FABoLLFlickableButton {
    enum PanDirection: Int, CaseIterable {
        case none
        case up
        case left
        case down
        case right
    }
}

private extension UISwipeGestureRecognizer.Direction {
    var panDirection: FABoLLFlickableButton.PanDirection {
        switch self {
        case .up:
            .up
        case .left:
            .left
        case .down:
            .down
        case .right:
            .right
        default:
            .none
        }
    }
}

