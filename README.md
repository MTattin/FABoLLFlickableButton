# FABoLLFlickableButton

[![FABoLL](https://custom-icon-badges.herokuapp.com/badge/license-FABoLL-8BB80A.svg?logo=law&logoColor=white)]()　
[![iOS 16.0](https://custom-icon-badges.herokuapp.com/badge/iOS-16.0-007bff.svg?logo=apple&logoColor=white)]()　
[![Xcode 16.2](https://custom-icon-badges.herokuapp.com/badge/Xcode-16.2-007bff.svg?logo=Xcode&logoColor=white)]()　
[![Swift 6.0](https://custom-icon-badges.herokuapp.com/badge/Swift-6.0-df5c43.svg?logo=Swift&logoColor=white)]()

You can add flick action to UIButton.  
If you use `FABoLLFlickableButton`, you can receive callback from  swipe gestures.

# Usage

```
// An appeared view when you swipe up
let up = UILabel()
up.backgroundColor = .brown
up.textColor = .white
up.textAlignment = .center
up.text = "UP"

// An appeared view when you swipe down
let down = UILabel()
down.backgroundColor = .clear
down.textAlignment = .center
down.text = "⚡️"

// An appeared view when you swipe left
let left = UIImageView(image: UIImage(named: "star")!.withRenderingMode(.alwaysTemplate))
left.tintColor = .red

// An appeared view when you swipe right
let right = UIImageView(image: UIImage(named: "star")!)
right.backgroundColor = .blue
right.clipsToBounds = true
right.layer.cornerRadius = button.frame.size.width * 0.5

// Add flick actions
button.setFlickable(
    settings: FABoLLFlickableButtonSettings(
        upView: up,
        leftView: left,
        downView: down,
        rightView: right,
        upMargin: 5,
        downMargin: 5
    ),
    callbackUp: {
        print("up")
    },
    callbackLeft: {
        print("left")
    },
    callbackDown: {
        print("down")
    },
    callbackRight: {
        print("right")
    }
)
// OR
var settings: FABoLLFlickableButtonSettings = .init()
settings.update(\.upView, up)
settings.update(\.leftView, left)
settings.update(\.downView, down)
settings.update(\.rightView, right)
settings.update(\.upMargin, 5)
settings.update(\.downMargin, 5)
button.setFlickable(
    settings: settings,
    callbackUp: {
        print("up")
    },
    callbackLeft: {
        print("left")
    },
    callbackDown: {
        print("down")
    },
    callbackRight: {
        print("right")
    }
)
```
