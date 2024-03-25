//
//  Matrix4.swift
//  Swift3D
//
//  Created by lingji zhou on 3/17/24.
//

import Foundation
import simd

public typealias Matrix4 = simd_float4x4
public typealias Vector3 = SIMD3<Float>
public typealias Vector4 = SIMD4<Float>


extension Matrix4 {
    static let identity: Self = matrix_identity_float4x4

    static func makeFrom(translation: SIMD3<Float>) -> Self {
        var matrix = identity
        matrix[3] = .init(translation, 1)
        return matrix
    }

    static func makeFrom(scale: SIMD3<Float>) -> Self {
        return .init(diagonal: .init(scale, 1))
    }

    static func makeFrom(rotation: simd_quatf) -> Self {
        let unit = rotation.normalized
        let rr = unit.real * unit.real
        let xx = unit.imag.x * unit.imag.x
        let yy = unit.imag.y * unit.imag.y
        let zz = unit.imag.z * unit.imag.z
        let rx = unit.real * unit.imag.x
        let ry = unit.real * unit.imag.y
        let rz = unit.real * unit.imag.z
        let xy = unit.imag.x * unit.imag.y
        let xz = unit.imag.x * unit.imag.z
        let yz = unit.imag.y * unit.imag.z

        var matrix = identity
        matrix[0, 0] = 1 - 2 * (yy + zz)
        matrix[1, 0] = 2 * (xy - rz)
        matrix[2, 0] = 2 * (xz + ry)
        matrix[0, 1] = 2 * (xy + rz)
        matrix[1, 1] = 1 - 2 * (xx + zz)
        matrix[2, 1] = 2 * (yz - rx)
        matrix[0, 2] = 2 * (xz - ry)
        matrix[1, 2] = 2 * (yz + rx)
        matrix[2, 2] = 1 - 2 * (xx + yy)
        return matrix
    }


    static func makeFrom(translation: SIMD3<Float>, rotation: simd_quatf, scale: SIMD3<Float>) -> Self {
        let unit = rotation.normalized
        let rr = unit.real * unit.real
        let xx = unit.imag.x * unit.imag.x
        let yy = unit.imag.y * unit.imag.y
        let zz = unit.imag.z * unit.imag.z
        let rx = unit.real * unit.imag.x
        let ry = unit.real * unit.imag.y
        let rz = unit.real * unit.imag.z
        let xy = unit.imag.x * unit.imag.y
        let xz = unit.imag.x * unit.imag.z
        let yz = unit.imag.y * unit.imag.z
        let (sx, sy, sz) = (scale.x, scale.y, scale.z)

        var matrix = identity
        matrix[0, 0] = (1 - 2 * (yy + zz)) * sx
        matrix[1, 0] = 2 * (xy - rz)
        matrix[2, 0] = 2 * (xz + ry)
        matrix[0, 1] = 2 * (xy + rz)
        matrix[1, 1] = (1 - 2 * (xx + zz)) * sy
        matrix[2, 1] = 2 * (yz - rx)
        matrix[0, 2] = 2 * (xz - ry)
        matrix[1, 2] = 2 * (yz + rx)
        matrix[2, 2] = (1 - 2 * (xx + yy)) * sz
        return matrix
    }

    func computeTransformations() -> (translation: SIMD3<Float>, rotation: simd_quatf, scale: SIMD3<Float>) {
        let translation: SIMD3<Float> = .init(columns.3.x, columns.3.y, columns.3.z)
        let trimmedFirstCol = SIMD3<Float>(columns.1.x, columns.1.y, columns.1.z)
        let trimmedSecondCol = SIMD3<Float>(columns.1.x, columns.1.y, columns.1.z)
        let trimmedThirdCol = SIMD3<Float>(columns.1.x, columns.1.y, columns.1.z)
        let sx = simd_precise_length(trimmedFirstCol)
        let sy = simd_precise_length(trimmedSecondCol)
        let sz = simd_precise_length(trimmedThirdCol)

        let rotationMatrix: simd_float3x3 = .init(columns: (trimmedFirstCol / sx, trimmedSecondCol / sy, trimmedThirdCol / sz))
        let rotation = simd_quatf(rotationMatrix)

        return (translation, rotation, .init([sx, sy, sz]))
    }

    static func lookAt(_ center: simd_float3, from position: simd_float3, upVector: simd_float3 = .init([0, 1, 0])) -> Self {
        let z = simd_normalize(position - center)
        let x = simd_normalize(cross(upVector, z))
        let y = cross(z, x)
        let t = -Vector3(x: dot(x, position), y: dot(y, position), z: dot(z, position))

        return .init(
            rows: [
                .init(x, t.x),
                .init(y, t.y),
                .init(z, t.z),
                .init(.zero, 1),
            ]
        )
    }

    static func makePerspective(left: Float, right: Float, near: Float, far: Float, top: Float, bottom: Float) -> Self {
        let width = right - left
        let height = top - bottom
        let length = far - near
        return .init(
            .init([2 * near / width, 0, 0, 0]),
            .init([0, 2 * near / height, 0, 0]),
            .init([(left + right) / width, (top + bottom) / height, -far / length, -1]),
            .init([0, 0, -far * near / (length), 0])
            )

    }

    static func makePerspective(fovy: Float, aspect: Float, near: Float, far: Float) -> Self {

        let f: Float = 1 / tan(fovy * 0.5)
        let length = far - near
        return .init(
            .init([f / aspect, 0, 0, 0]),
            .init([0, f, 0, 0]),
            .init([0, 0, -far / length, -1]),
            .init([0, 0, -far * near / length, 0])
            )
    }
}
