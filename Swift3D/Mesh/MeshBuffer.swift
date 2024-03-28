//
//  MeshBuffer.swift
//  Swift3D
//
//  Created by lingji zhou on 3/27/24.
//

import Foundation

enum RKMeshBuffers {
    struct Identifier: Hashable, Equatable {
        let name: String
        let isCustom: Bool = false

        static let normals: Self = .init(name: "vertexNormal")
        static let positions: Self = .init(name: "vertexPositions")
        static let textureCoordinates: Self = .init(name: "vertexUV")
    }
    struct Semantic<Element>: Identifiable {
        let id: Identifier
    }

    static let normals: Semantic<SIMD3<Float>> = .init(id: .normals)
    static let positions: Semantic<SIMD3<Float>> = .init(id: .positions)
    static let textureCoordniates: Semantic<SIMD2<Float>> = .init(id: .textureCoordinates)

    
    struct MeshBuffer {

    }
}
struct AnyMeshBuffer {
    
}


