# FABoLLFlickableButton

[![FABoLL](https://custom-icon-badges.herokuapp.com/badge/license-FABoLL-8BB80A.svg?logo=law&logoColor=white)]()　[![iOS 16.0](https://custom-icon-badges.herokuapp.com/badge/iOS-16.0-007bff.svg?logo=apple&logoColor=white)]()　[![Xcode 15.3](https://custom-icon-badges.herokuapp.com/badge/Xcode-15.3-007bff.svg?logo=Xcode&logoColor=white)]()　[![Swift 5.9](https://custom-icon-badges.herokuapp.com/badge/Swift-5.9-df5c43.svg?logo=Swift&logoColor=white)]()

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

/// Add flick actions
button.setFlickable(
    settings: FABoLLFlickableButtonSettings(
        views: (up: up, left: left, down: down, right: right),
        margins: (up: 5., left: 10, down: 5, right: 10),
        animationDuration: nil
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
```
