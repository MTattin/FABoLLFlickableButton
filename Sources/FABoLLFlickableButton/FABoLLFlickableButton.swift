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
import UIKit
///
/// Added top, bottom, left, right swipe action
///
/// - Tag: FABoLLFlickableButton
///
public class FABoLLFlickableButton: UIButton {
    ///
    // MARK: ------------------------------ enum
    ///
    ///
    ///
    private enum _PanDirection: Int, CaseIterable {
        case none
        case up
        case left
        case down
        case right
    }
    ///
    // MARK: ------------------------------ properties
    ///
    ///
    ///
    private var _settings: FABoLLFlickableButtonSettings = FABoLLFlickableButtonSettings.init(
        views: (
            up: nil,
            left: nil,
            down: nil,
            right: nil
        ),
        margins: (
            up: 0.0,
            left: 0.0,
            down: 0.0,
            right: 0.0
        )
    )
    ///
    ///
    ///
    private var _upCenter: CGPoint {
        return CGPoint.init(
            x: self.center.x,
            y: self.center.y - self.frame.height - self._settings.margins.up
        )
    }
    private var _leftCenter: CGPoint {
        return CGPoint.init(
            x: self.center.x - self.frame.width - self._settings.margins.left,
            y: self.center.y
        )
    }
    private var _downCenter: CGPoint {
        return CGPoint.init(
            x: self.center.x,
            y: self.center.y + self.frame.height + self._settings.margins.up
        )
    }
    private var _rightCenter: CGPoint {
        return CGPoint.init(
            x: self.center.x + self.frame.width + self._settings.margins.left,
            y: self.center.y
        )
    }
    ///
    ///
    ///
    private var _callbackUp: (() -> Void)?
    private var _callbackLeft: (() -> Void)?
    private var _callbackDown: (() -> Void)?
    private var _callbackRight: (() -> Void)?
    ///
    ///
    ///
    private var _panStart: CGPoint = CGPoint.zero
    ///
    // MARK: -------------------- properties method
    ///
    ///
    ///
    private func _getTarget(
        _ direction: FABoLLFlickableButton._PanDirection
    ) -> (
        view: UIView?,
        center: CGPoint,
        callback: (() -> Void)?
    ) {
        switch direction {
        case .none:
            return (nil, self.center, nil)
        case .up:
            return (self._settings.views.up, self._upCenter, self._callbackUp)
        case .left:
            return (self._settings.views.left, self._leftCenter, self._callbackLeft)
        case .down:
            return (self._settings.views.down, self._downCenter, self._callbackDown)
        case .right:
            return (self._settings.views.right, self._rightCenter, self._callbackRight)
        }
    }
    ///
    ///
    ///
    private func _convert(from: UISwipeGestureRecognizer.Direction) -> FABoLLFlickableButton._PanDirection {
        switch from {
        case .up:
            return FABoLLFlickableButton._PanDirection.up
        case .left:
            return FABoLLFlickableButton._PanDirection.left
        case .down:
            return FABoLLFlickableButton._PanDirection.down
        case .right:
            return FABoLLFlickableButton._PanDirection.right
        default:
            return FABoLLFlickableButton._PanDirection.none
        }
    }
    ///
    // MARK: -------------------- life cycle
    ///
    ///
    ///
    deinit {
        print("FlickableButton released")
    }
    ///
    /// `settings` define is [FABoLLFlickableButtonSettings](x-source-tag://FABoLLFlickableButtonSettings).
    ///
    public func setFlickable(
        settings: FABoLLFlickableButtonSettings,
        callbackUp: (() -> Void)?,
        callbackLeft: (() -> Void)?,
        callbackDown: (() -> Void)?,
        callbackRight: (() -> Void)?
    ) {
        self._settings = settings
        self._callbackUp = callbackUp
        self._callbackLeft = callbackLeft
        self._callbackDown = callbackDown
        self._callbackRight = callbackRight
        self._setViews()
        self._setGesture()
    }
    ///
    ///
    ///
    private func _setViews() {
        [
            self._settings.views.up,
            self._settings.views.left,
            self._settings.views.down,
            self._settings.views.right,
        ].forEach { (item: UIView?) in
            guard let view: UIView = item else {
                return
            }
            view.isUserInteractionEnabled = false
            view.alpha = 0.0
            self.superview?.addSubview(view)
        }
    }
    ///
    ///
    ///
    private func _setGesture() {
        [
            UISwipeGestureRecognizer.Direction.up,
            UISwipeGestureRecognizer.Direction.left,
            UISwipeGestureRecognizer.Direction.down,
            UISwipeGestureRecognizer.Direction.right,
        ].forEach { (direction: UISwipeGestureRecognizer.Direction) in
            let swipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer.init(
                target: self,
                action: #selector(self._swiped(_:))
            )
            swipe.direction = direction
            self.addGestureRecognizer(swipe)
        }
        ///
        ///
        ///
        let long: UILongPressGestureRecognizer = UILongPressGestureRecognizer.init(
            target: self,
            action: #selector(self._longPressed(_:))
        )
        long.minimumPressDuration = 0.5
        self.addGestureRecognizer(long)
    }
    ///
    // MARK: -------------------- swipe
    ///
    ///
    ///
    @objc private func _swiped(_ gesture: UISwipeGestureRecognizer) {
        let direction: FABoLLFlickableButton._PanDirection = self._convert(from: gesture.direction)
        if direction == .none {
            return
        }
        let target: (view: UIView?, center: CGPoint, callback: (() -> Void)?) = self._getTarget(direction)
        self._showFlickableView(target.view, target.center)
        target.callback?()
    }
    ///
    ///
    ///
    private func _showFlickableView(_ view: UIView?, _ center: CGPoint) {
        guard let view: UIView = view else {
            return
        }
        view.frame.size = self.frame.size
        view.center = center
        UIView.animate(
            withDuration: 0.25,
            animations: { [weak view] in
                view?.alpha = 1.0
            }
        ) { [weak view] (_) in
            UIView.animate(
                withDuration: 0.25,
                delay: 0.5,
                options: UIView.AnimationOptions.curveEaseIn,
                animations: { [weak view] in
                    view?.alpha = 0.0
                },
                completion: { (_) in }
            )
        }
    }
    ///
    // MARK: -------------------- long press
    ///
    ///
    ///
    @objc private func _longPressed(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            self._showAndHideAllFlickableViews(isHidden: false)
            self._panStart = gesture.location(in: self)
            return
        }
        if gesture.state == .changed {
            let point: CGPoint = gesture.location(in: self)
            let direction: FABoLLFlickableButton._PanDirection = self._getPanDirection(point)
            if direction == .none {
                return
            }
            self._panShowFlickableView(direction)
            return
        }
        let point: CGPoint = gesture.location(in: self)
        let direction: FABoLLFlickableButton._PanDirection = self._getPanDirection(point)
        if direction == .none {
            self._hideAllFlickableView()
        } else {
            self._panExecuteFlickableView(direction)
        }
    }
    ///
    ///
    ///
    private func _showAndHideAllFlickableViews(isHidden: Bool) {
        self.alpha = (isHidden) ? 1.0 : 0.5
        FABoLLFlickableButton._PanDirection.allCases.forEach { (direction: FABoLLFlickableButton._PanDirection) in
            let target: (view: UIView?, center: CGPoint, callback: (() -> Void)?) = self._getTarget(direction)
            target.view?.frame.size = self.frame.size
            target.view?.center = target.center
            target.view?.alpha = (isHidden == true) ? 0.0 : 1.0
        }
    }
    ///
    ///
    ///
    private func _getPanDirection(_ point: CGPoint) -> FABoLLFlickableButton._PanDirection {
        if
            abs(point.x - self._panStart.x) < self.frame.width * 0.5 &&
            abs(point.y - self._panStart.y) < self.frame.height * 0.5
        {
            return .none
        }
        let diffX: CGFloat = point.x - self._panStart.x
        let diffY: CGFloat = point.y - self._panStart.y
        if abs(diffX) < abs(diffY) {
            return (diffY < 0.0)
                ? FABoLLFlickableButton._PanDirection.up
                : FABoLLFlickableButton._PanDirection.down
        } else {
            return (diffX < 0.0)
                ? FABoLLFlickableButton._PanDirection.left
                : FABoLLFlickableButton._PanDirection.right
        }
    }
    ///
    /// Hide all Flickable views except target (parameter `to`)
    ///
    private func _panShowFlickableView(_ to: FABoLLFlickableButton._PanDirection) {
        FABoLLFlickableButton._PanDirection.allCases
            .filter { (direction: FABoLLFlickableButton._PanDirection) -> Bool in
                direction != to
            }
            .forEach { (direction: FABoLLFlickableButton._PanDirection) in
                self._getTarget(direction).view?.alpha = 0.0
            }
    }
    ///
    ///
    ///
    private func _hideAllFlickableView() {
        UIView.animate(
            withDuration: 0.25,
            delay: 0.25,
            options: UIView.AnimationOptions.curveEaseIn,
            animations: { [weak self] in
                self?.alpha = 1.0
                self?._settings.views.up?.alpha = 0.0
                self?._settings.views.left?.alpha = 0.0
                self?._settings.views.down?.alpha = 0.0
                self?._settings.views.right?.alpha = 0.0
            },
            completion: { (_) in }
        )
    }
    ///
    ///
    ///
    private func _panExecuteFlickableView(_ direction: FABoLLFlickableButton._PanDirection) {
        self.alpha = 1.0
        UIView.animate(
            withDuration: 0.25,
            delay: 0.5,
            options: UIView.AnimationOptions.curveEaseIn,
            animations: { [weak self] in
                self?._getTarget(direction).view?.alpha = 0.0
            },
            completion: { (_) in }
        )
        self._getTarget(direction).callback?()
    }
}
