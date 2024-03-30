//
//  Object3D.swift
//  Swift3D
//
//  Created by lingji zhou on 3/16/24.
//

import Foundation
import simd


private var id: UInt32 = 0
class RKEntity: Identifiable {
    static private var id: UInt64 = .zero
    var mesh: RKMeshResource
    init(mesh: RKMeshResource) {
        self.mesh = mesh
    }

    var parent: RKEntity? = nil
    var name: String? = nil
    var children: [RKEntity] = []
    let id = {
        let currentId = id
        id += 1
        return currentId
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
