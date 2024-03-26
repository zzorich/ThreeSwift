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

    }

    private(set) var data: Data
    private let semantic: Semantic
    private let vectorCount: Int
    private let usesFloatComponents: Bool
    private let componentsPerVector: Int
    private let bytesPerComponent: Int
    private let dataOffset: Int
    private let dataStride: Int
}
