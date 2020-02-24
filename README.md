# FABoLLFlickableButton

You can add flick action to UIButton.  
If you use `FABoLLFlickableButton`, you can receive callback from  swipe gestures.


# License
MIT


# Dependency

- iOS, >=11
- Xcode, >= 11


# Usage

```
let up: UILabel = UILabel.init()
up.backgroundColor = UIColor.brown
up.textColor = UIColor.white
up.textAlignment = NSTextAlignment.center
up.text = "UP"
let down: UILabel = UILabel.init()
down.backgroundColor = UIColor.clear
down.textAlignment = NSTextAlignment.center
down.text = "⚡️"
let left: UIImageView = UIImageView
    .init(image: UIImage.init(named: "star")!
    .withRenderingMode(UIImage.RenderingMode.alwaysTemplate))
left.tintColor = Skin.CmnColors.Apple.ApplePurple
let right: UIImageView = UIImageView.init(image: UIImage.init(named: "star")!)
right.backgroundColor = Skin.CmnColors.Apple.ApplePurple
right.clipsToBounds = true
right.layer.cornerRadius = self.button44.frame.size.width * 0.5
self.button44.setFlickable(
    settings: FlickableButtonSettings.init(
        views: (
            up: up,
            left: left,
            down: down,
            right: right
        ),
        margins: (
            up: 5.0,
            left: 5.0,
            down: 5.0,
            right: 5.0
        )
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
