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
    struct Semantic<Element>: Identifiable, RKMeshBufferSemantic {
        let id: Identifier
        let elementType: RKMeshBuffers.ElementType
    }

    static let normals: Semantic<SIMD3<Float>> = .init(id: .normals, elementType: .float3)
    static let positions: Semantic<SIMD3<Float>> = .init(id: .positions, elementType: .float3)
    static let textureCoordniates: Semantic<SIMD2<Float>> = .init(id: .textureCoordinates, elementType: .float2)

    enum ElementType {
        case int8, uint8, int32, uint32, float3, float4, float, float2
    }

}

struct RKMeshBuffer<Element> {
    let elements: [Element]
    init(_ elements: [Element]) {
        self.elements = elements
    }

    init(elements: [Element], indices: [UInt32]) {
        self.elements = zip(indices, elements).sorted {
            $0.0 < $1.0
        }.map({ $0.1 })
    }
}

struct RKAnyMeshBuffer {
    let count: Int
    let elementType: RKMeshBuffers.ElementType
    let data: Data
    init<Element>(buffer: RKMeshBuffer<Element>, elementType: RKMeshBuffers.ElementType) {
        self.count = buffer.elements.count
        self.data = buffer.elements.withUnsafeBufferPointer { buffer_ptr in
            Data(buffer: buffer_ptr)
        }
        self.elementType = elementType
    }
    func get<Value>(_ V: Value.Type = Value.self) -> RKMeshBuffer<Value>? {
        .init(data.withUnsafeBytes { bufferPtr in
            [Value](bufferPtr.bindMemory(to: V))
        })
    }

}

extension RKAnyMeshBuffer {
    init(buffer: RKMeshBuffer<SIMD3<Float>>) {
        self.init(buffer: buffer, elementType: .float3)
    }

    init(buffer: RKMeshBuffer<SIMD4<Float>>) {
        self.init(buffer: buffer, elementType: .float4)
    }

    init(buffer: RKMeshBuffer<Float>) {
        self.init(buffer: buffer, elementType: .float)
    }

    init(buffer: RKMeshBuffer<SIMD2<Float>>) {
        self.init(buffer: buffer, elementType: .float2)
    }
}


protocol RKMeshBufferSemantic: Identifiable {
    associatedtype Element
    var id: RKMeshBuffers.Identifier { get }
    var elementType: RKMeshBuffers.ElementType { get }
}


