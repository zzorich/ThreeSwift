//
//  Euler.swift
//  Swift3D
//
//  Created by lingji zhou on 3/17/24.
//

import Foundation
import simd
private let ONE_EPSLION: Float = 0.9999999
struct Euler {
    enum Order { case XYZ, YXZ, ZXY, YZX, XZY }
    private var angles: SIMD3<Float>

    init(angles: SIMD3<Float>) {
        self.angles = angles
    }

    init(x: Float, y: Float, z: Float) {
        self.init(angles: .init(x: x, y: y, z: z))
    }


    var x: Float {
        set { angles.x = newValue }
        get { angles.x }
    }
    var y: Float {
        set { angles.y = newValue }
        get { angles.y }
    }
    var z: Float {
        set { angles.z = newValue }
        get { angles.z }
    }

    static func make(from rotation: simd_float3x3, order: Order = .XYZ) -> Self {
        let (m11, m21, m31) = (rotation[0].x, rotation[0].y, rotation[0].z)
        let (m12, m22, m32) = (rotation[1].x, rotation[1].y, rotation[1].z)
        let (m13, m23, m33) = (rotation[2].x, rotation[2].y, rotation[2].z)
        let y = asin(simd_clamp(m13, -1, 1))
        let nearOne = abs(m13) >= ONE_EPSLION
        let x = nearOne ? atan2(m32, m22) : atan2(-m23, m33)
        let z = nearOne ? 0 : atan2(-m13, m11)
        return .init(x: x, y: y, z: z)
    }
}

