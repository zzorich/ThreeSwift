//
//  MeshResource.swift
//  Swift3D
//
//  Created by lingji zhou on 3/27/24.
//

import Foundation

@MainActor
class RKMeshResource {
    init(
        mesh: RKMeshResource,
        materials: [any RKMaterial]
    ) {
        
    }
}

struct RKMeshDescriptor: RKMeshBufferContainer {
    enum Primitives {
        case polygons(count: [UInt8], indices: [UInt32])
        case triangles(indices: [UInt32])
        case trianglesAndQuads(triangles: [UInt32], quads: [UInt32])
    }
    init(name: String = "") { self.name = name }
    typealias Identifier = RKMeshBuffers.Identifier
    var buffers: [Identifier: RKAnyMeshBuffer] = [:]
    var name: String
    var primitives: Primitives? = nil
}

protocol RKMeshBufferContainer {
    var buffers: [RKMeshBuffers.Identifier: RKAnyMeshBuffer] { get set }
    var positions: RKMeshBuffer<SIMD3<Float>>? { get set }
    var normals: RKMeshBuffer<SIMD3<Float>>? { get set }
    var textureCoordinates: RKMeshBuffer<SIMD2<Float>>? { get set }
}

extension RKMeshBufferContainer {
    var positions: RKMeshBuffer<SIMD3<Float>>? {
        set {
            guard let newValue else { return }
            buffers[.positions] = RKAnyMeshBuffer(buffer: newValue)
        }
        get {
            self[RKMeshBuffers.positions]
        }
    }

    var normals: RKMeshBuffer<SIMD3<Float>>? {
        set {
            guard let newValue else { return }
            buffers[.normals] = RKAnyMeshBuffer(buffer: newValue)
        }
        get {
            self[RKMeshBuffers.normals]
        }
    }


    var textureCoordinates: RKMeshBuffer<SIMD2<Float>>? {
        set {
            guard let newValue else { return }
            buffers[.textureCoordinates] = RKAnyMeshBuffer(buffer: newValue)
        }
        get {
            self[RKMeshBuffers.textureCoordniates]
        }
    }

    subscript<S>(semantic: S) -> RKMeshBuffer<S.Element>? where S: RKMeshBufferSemantic {
        get {
            let id = semantic.id
            return buffers[id]?.get(S.Element.self)
        }
        set {
            guard let newValue else { return }
            buffers[semantic.id] = RKAnyMeshBuffer(buffer: newValue, elementType: semantic.elementType)
        }
    }
}
