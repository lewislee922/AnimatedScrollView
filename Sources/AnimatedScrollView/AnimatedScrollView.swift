//
//  AnimatedScrollView.swift
//
//
//  Created by Lewis Lee on 2024/1/2.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, *)
public struct AnimatedScrollView<Content,T>: View where T: Hashable, Content: View {
    typealias T = Hashable
    
    /// The value to activate view transition.
    ///
    let treshould: Double
    
    /// The scrollable axes of the scroll view.
    ///
    /// The default value is ``Axis/vertical``.
    let axis: Axis.Set
    
    /// The identified data to create views dynamically.
    let items: [T]
    
    /// Creates a view that represents item and view transition state.
    @ViewBuilder let itemBuilder: (T, Double) -> Content
    
    public init(axis: Axis.Set = .vertical, treshould: Double = 0.4, items: [T], @ViewBuilder itemBuilder: @escaping (T, Double) -> Content) {
        self.axis = axis
        self.items = items
        self.treshould = treshould.clamped(to: 0...1)
        self.itemBuilder = itemBuilder
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ScrollView(axis) {
                if axis == .vertical {
                    LazyVStack {
                        ForEach(items, id: \.self) { item in
                            AnimatedScrollViewItem(axis: axis, treshould: treshould, viewSize: geometry.size, item: item, itemBuilder: itemBuilder)
                        }
                    }
                }
                
                if axis == .horizontal {
                    LazyHStack {
                        ForEach(items, id: \.self) { item in
                            AnimatedScrollViewItem(axis: axis, treshould: treshould, viewSize: geometry.size, item: item, itemBuilder: itemBuilder)
                        }
                    }
                }
            }
            .coordinateSpace(name: "Scrollable")
        }
    }
}
