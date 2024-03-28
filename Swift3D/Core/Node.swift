//
//  Object3D.swift
//  Swift3D
//
//  Created by lingji zhou on 3/16/24.
//

import Foundation
import simd


class Node: Identifiable {
    static private var id: UInt64 = .zero
    var geometry: Geometry
    init(geometry: Geometry) {
        self.geometry = geometry
    }

    var parent: Node? = nil
    var name: String? = nil
    var children: [Node] = []
    let id = {
        Node.id += 1
        return Node.id - 1
    }()

    var simdTransform: simd_float4x4 = .identity
    var simdPosition: simd_float3 = .zero {
        didSet {
            simdTransform = .makeFrom(translation: simdPosition, rotation: simdOrientation, scale: simdScale)
        }
    }
    var simdOrientation: simd_quatf = .init(real: 1, imag: .zero) {
        didSet {
            simdTransform = .makeFrom(translation: simdPosition, rotation: simdOrientation, scale: simdScale)
        }
    }
    var simdScale: simd_float3 = .one {
        didSet {
            simdTransform = .makeFrom(translation: simdPosition, rotation: simdOrientation, scale: simdScale)
        }
    }

    func apply(transform: simd_float4x4) {
        simdTransform = transform * simdTransform
        (simdPosition, simdOrientation, simdScale) = simdTransform.computeTransformations()
    }

    var simdWorldTransform: simd_float4x4 {
        guard let parent else { return simdTransform }
        return simdTransform * parent.simdWorldTransform
    }
}
