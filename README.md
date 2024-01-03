# AnimatedScrollView

A customized ScrollView can add item transition when scrolling.

Support iOS 14+, macOS 11+

![demo](https://github.com/lewislee922/AnimatedScrollView/assets/33001057/859733b1-944e-46f7-bfd0-4b471c01c0f4)

# Usage
Just import AnimatedScrollView and add to your view.

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
