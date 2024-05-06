//
//  FABoLLFlickableButton.swift
//
//  Created by Masakiyo Tachikawa on 2020/02/21.
//  Copyright © 2020 FABoLL. All rights reserved.
//
//  Copyright 2020 Masakiyo Tachikawa
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  © 2023 Masakiyo Tachikawa
//

import UIKit

// MARK: - FABoLLFlickableButton

/// Added top, bottom, left, right swipe action
public class FABoLLFlickableButton: UIButton {

    // MARK: - typealias

    private typealias FlickableView = (view: UIView?, center: CGPoint, callback: (() -> Void)?)

    // MARK: - enum

    fileprivate enum PanDirection: Int, CaseIterable {

        case none

        case up

        case left

        case down

        case right
    }

    // MARK: - Properties

    private var settings = FABoLLFlickableButtonSettings(
        views: (
            up: nil,
            left: nil,
            down: nil,
            right: nil
        ),
        margins: nil,
        animationDuration: nil
    )

    private var upCenter: CGPoint { CGPoint(x: center.x, y: center.y - frame.height - settings.margins.up) }

    private var leftCenter: CGPoint { CGPoint(x: center.x - frame.width - settings.margins.left, y: center.y) }

    private var downCenter: CGPoint { CGPoint(x: center.x, y: center.y + frame.height + settings.margins.up) }

    private var rightCenter: CGPoint { CGPoint(x: center.x + frame.width + settings.margins.left, y: center.y) }

    private var callbackUp: (() -> Void)?

    private var callbackLeft: (() -> Void)?

    private var callbackDown: (() -> Void)?

    private var callbackRight: (() -> Void)?

    private var panStart: CGPoint = .zero

    private var showDuration: Double { settings.animationDuration.show }

    private var hideDuration: Double { settings.animationDuration.hide }

    private var stayDuration: Double { settings.animationDuration.stay }


    // MARK: - Conveniences

    private func getTarget(_ direction: FABoLLFlickableButton.PanDirection) -> FlickableView {
        switch direction {
        case .none:
            (nil, center, nil)
        case .up:
            (settings.views.up, upCenter, callbackUp)
        case .left:
            (settings.views.left, leftCenter, callbackLeft)
        case .down:
            (settings.views.down, downCenter, callbackDown)
        case .right:
            (settings.views.right, rightCenter, callbackRight)
        }
    }

    // MARK: - Life cycle

    deinit {
        print("FlickableButton released")
    }

    /// `settings` define is FABoLLFlickableButtonSettings.
    public func setFlickable(
        settings: FABoLLFlickableButtonSettings,
        callbackUp: (() -> Void)?,
        callbackLeft: (() -> Void)?,
        callbackDown: (() -> Void)?,
        callbackRight: (() -> Void)?
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
            settings.views.up,
            settings.views.left,
            settings.views.down,
            settings.views.right,
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
        if direction == .none {
            return
        }
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
            if direction == .none {
                return
            }
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
            self.settings.views.up?.alpha = 0
            self.settings.views.left?.alpha = 0
            self.settings.views.down?.alpha = 0
            self.settings.views.right?.alpha = 0
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

