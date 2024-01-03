//
//  AnimatedScrollViewItem.swift
//  
//
//  Created by Lewis Lee on 2024/1/2.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, *)
public struct AnimatedScrollViewItem<Content, T>: View where Content: View, T: Hashable {
    typealias T = Hashable
    
    let axis: Axis.Set
    let viewSize: CGSize
    let treshould: Double
    let item: T
    
    @ViewBuilder let itemBuilder: (T, Double) -> Content

    @State private var transitionState: Double = 0.0
    
    public init(axis: Axis.Set = .vertical, treshould: Double = 0.4, viewSize: CGSize, item: T, @ViewBuilder itemBuilder: @escaping (T, Double) -> Content) {
        self.axis = axis
        self.item = item
        self.viewSize = viewSize
        self.treshould = treshould
        self.itemBuilder = itemBuilder
    }
    
    public var body: some View {
        itemBuilder(item, transitionState)
            .disabled(transitionState > 0)
            .background(
                GeometryReader{ localGeo in
                    let size = localGeo.size
                    let origin = localGeo.frame(in: .named("Scrollable")).origin
                    let ratio = getTransitionState(from: origin, itemSize: size, viewSize: viewSize)
                    let _ = update(newState: ratio)
                    Color.clear
                        .onAppear {
                            update(newState: ratio)
                        }
                }
            )
    }
    
    private func update(newState: Double) {
        // set a treshould that prevent changing state too frequently.
        if (abs(transitionState - newState) >= 0.005){
            DispatchQueue.main.async {
                self.transitionState = newState
            }
        }
    }
    
    private func getTransitionState(from origin: CGPoint, itemSize: CGSize, viewSize: CGSize) -> Double {
        var anchor = 0.0
        var view = 0.0
        var item = 0.0
        
        // set value with axis
        if (axis == .vertical) {
            anchor = origin.y
            view = viewSize.height
            item = itemSize.height
        }else {
            anchor = origin.x
            view = viewSize.width
            item = itemSize.width
        }
        
        if (anchor <= 0.0) {
            return (-anchor / item - treshould).clamped(to: 0...1)
        }else if (anchor <= view) {
            if(anchor < view - item) {
                return 0.0
            }
        }
        let newRatio = ((anchor - (view - item)) / item).clamped(to: 0...1)
        return (newRatio - treshould).clamped(to: 0...1)
    }
}
