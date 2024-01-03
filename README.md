# AnimatedScrollView

A customized ScrollView can add item transition when scrolling.

Support iOS 14+, macOS 11+

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
