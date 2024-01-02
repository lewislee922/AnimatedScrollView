//
//  Extensions.swift
//  
//
//  Created by Lewis Lee on 2024/1/2.
//

extension Comparable {
    @inlinable @inline(__always)
    public func clamped(to limits: ClosedRange<Self>) -> Self {
        Swift.min(Swift.max(self, limits.lowerBound), limits.upperBound)
    }
}
