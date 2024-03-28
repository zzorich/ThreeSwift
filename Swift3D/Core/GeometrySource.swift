//
//  BufferAttribute.swift
//  Swift3D
//
//  Created by lingji zhou on 3/16/24.
//

import Foundation
import simd
import SceneKit


class GeometrySource {
    init(data: Data, semantic: Semantic, vectorCount: Int, componentsPerVector: Int, bytesPerComponent: Int, dataOffset: Int, dataStride: Int, usesFloatComponents: Bool) {
        self.data = data
        self.semantic = semantic
        self.vectorCount = vectorCount
        self.componentsPerVector = componentsPerVector
        self.bytesPerComponent = bytesPerComponent
        self.dataOffset = dataOffset
        self.dataStride = dataStride
        self.usesFloatComponents = usesFloatComponents
    }
    enum Semantic {
        case position, normal, textCoord
    }

    let data: Data
    let semantic: Semantic
    let vectorCount: Int
    let usesFloatComponents: Bool
    let componentsPerVector: Int
    let bytesPerComponent: Int
    let dataOffset: Int
    let dataStride: Int
}
