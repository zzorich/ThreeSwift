//
//  PerspectiveCamera.swift
//  Swift3D
//
//  Created by lingji zhou on 3/21/24.
//

import Foundation
import simd

class PerspectiveCamera {
    var focal: Float = .pi / 3.0  { didSet { isUniformDirty = true} }
    var position: Vector3 = .zero { didSet { isUniformDirty = true } }
    var aspect: Float = 1 { didSet { isUniformDirty = true } }
    var zNear: Float = 0.1 { didSet { isUniformDirty = true } }
    var zFar: Float = 100 { didSet { isUniformDirty = true } }
    var up: Vector3 = .init([0, 1, 0]) { didSet { isUniformDirty = true } }
    var direction: Vector3 = .init([0, 0, -1]) { didSet { isUniformDirty = true } }

    private var uniforms: Uniforms = .init()
    private var isUniformDirty = true
    private func orthogonalize() {
        direction = normalize(direction)
        let right = normalize(cross(direction, up))
        up = cross(right, direction)
    }


    struct Uniforms {
        var viewMatrix: simd_float4x4 = .identity
        var projectionMatrix: simd_float4x4 = .identity
    }
    
    var viewMatrix: simd_float4x4 {
        updateUniformsIfNeeded()
        return uniforms.viewMatrix
    }


    var projectionMatrix: simd_float4x4 {
        updateUniformsIfNeeded()
        return uniforms.projectionMatrix
    }

    private func updateUniformsIfNeeded() {
        guard isUniformDirty else { return }
        orthogonalize()
        uniforms.viewMatrix = .lookAt(position + direction, from: position)
        uniforms.projectionMatrix = .makePerspective(fovy: focal, aspect: aspect, near: zNear, far: zFar)
        isUniformDirty = false
    }
}



