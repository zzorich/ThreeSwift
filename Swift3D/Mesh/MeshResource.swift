//
//  MeshResource.swift
//  Swift3D
//
//  Created by lingji zhou on 3/27/24.
//

import Foundation

@MainActor
class RKMeshResource {

}

struct RKMeshDescriptor {
    enum Primitives {
        case polygons(count: [UInt8], indices: [UInt32])
        case triangles(indices: [UInt32])
        case trianglesAndQuads(triangles: [UInt32], quads: [UInt32])
    }
    init(name: String) {
        self.name = name
    }
    private(set) var buffers: [RKMeshBuffer.Identifier: AnyMeshBuffer] = [:]
    var name: String
    var primitives: Primitives? = nil
}

