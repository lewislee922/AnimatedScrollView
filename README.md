# AnimatedScrollView

A customized ScrollView can add item transition when scrolling.

Support iOS 14+, macOS 11+

<img src="https://github.com/lewislee922/AnimatedScrollView/assets/33001057/859733b1-944e-46f7-bfd0-4b471c01c0f4" alt="demo" height="420" width="260"/>

## Installation
### Swift Package Manager

```swift
.package(url: "https://github.com/lewislee922/AnimatedScrollView.git", from: "1.0.5")
```

Then `import AnimatedScrollView` in any Swift file in your module.

## Usage
### Example
```swift
struct YourView: View {
    private let hashableArray = (0..<100).map { index in
        "\(index)"
    }
    
    var body: some View {
        AnimatedScrollView(items: hashableArray) { item, transitionState in
            Text(item)
                .font(.title)
                .opacity(1-transitionState)
                .scaleEffect(1-transitionState)
        }
    }
}
```
