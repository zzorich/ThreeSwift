//
//  GeometryElement.swift
//  Swift3D
//
//  Created by lingji zhou on 3/25/24.
//

import Foundation

class GeometryElement {
    enum GeometryPrimitiveType: Int {
        case triangle
        case triangleStrip
        case line
        case point
    }
    let data: Data?
    let primitiveType: GeometryPrimitiveType
    let primitiveCount: Int
    let bytesPerIndex: Int

    var pointSize: CGFloat = .zero

    init(data: Data?, primitiveType: GeometryPrimitiveType, primitiveCount: Int, bytesPerIndex: Int) {
        self.data = data
        self.primitiveType = primitiveType
        self.primitiveCount = primitiveCount
        self.bytesPerIndex = bytesPerIndex
    }


}
