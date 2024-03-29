# FABoLLFlickableButton

You can add flick action to UIButton.  
If you use `FABoLLFlickableButton`, you can receive callback from  swipe gestures.


# License
MIT


# Dependency

- iOS, >=14
- Xcode, >= 13


# Usage

```
///
/// An appeared view when you swipe up
///
let up: UILabel = UILabel.init()
up.backgroundColor = UIColor.brown
up.textColor = UIColor.white
up.textAlignment = NSTextAlignment.center
up.text = "UP"
///
/// An appeared view when you swipe down
///
let down: UILabel = UILabel.init()
down.backgroundColor = UIColor.clear
down.textAlignment = NSTextAlignment.center
down.text = "⚡️"
///
/// An appeared view when you swipe left
///
let left: UIImageView = UIImageView
    .init(image: UIImage.init(named: "star")!
    .withRenderingMode(UIImage.RenderingMode.alwaysTemplate))
left.tintColor = UIColor.red
///
/// An appeared view when you swipe right
///
let right: UIImageView = UIImageView.init(image: UIImage.init(named: "star")!)
right.backgroundColor = UIColor.blue
right.clipsToBounds = true
right.layer.cornerRadius = self.button.frame.size.width * 0.5
///
/// Add flick actions
///
self.button.setFlickable(
    settings: FABoLLFlickableButtonSettings.init(
        views: (
            up: up,
            left: left,
            down: down,
            right: right
        ),
        margins: (
            up: 5.0,
            left: 10.0,
            down: 5.0,
            right: 10.0
        ),
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
