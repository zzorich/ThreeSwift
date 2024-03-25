//
//  BufferAttribute.swift
//  Swift3D
//
//  Created by lingji zhou on 3/16/24.
//

import Foundation
import simd
struct BufferAttribute<Data> {
    public var buffer: [Data]
    public let itemSize: Int
    public var itemCount: Int { buffer.count / itemSize }
    public let normalized = false

    private var updateRanges = [(offset: Int, count: Int)]()

    @inlinable
    public mutating func addUpdateRange(start: Int, count: Int) { updateRanges.append((start, count)) }
}


extension BufferAttribute<Float> {
    mutating func apply(matrix: simd_float3x3) throws {
        if itemSize == 2 {
            for i in 0..<itemCount {
                let offset = i * itemSize
                var vec = vector_float3(buffer[offset], buffer[offset+1], 1)
                vec = matrix * vec
                buffer[offset..<offset+2] = [vec.x, vec.y]
            }
        } else if itemSize == 3 {
            for i in 0..<itemCount {
                let offset = i * itemSize
                var vec = vector_float3(buffer[offset..<offset+itemSize])
                vec = matrix * vec
                buffer[offset..<offset+itemSize] = [vec.x, vec.y, vec.z]
            }
        } else {
            throw BufferError.unsupportedOpertions
        }
    }
}

enum BufferError: Error {
    case unsupportedOpertions
}
