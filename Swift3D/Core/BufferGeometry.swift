//
//  BufferGeometry.swift
//  Swift3D
//
//  Created by lingji zhou on 3/25/24.
//

import Foundation

class BufferGeometry {
    static var _id = 0
    let id: Int = {
        BufferGeometry._id += 1
        return BufferGeometry._id - 1
    }()
    let uuid: UUID = .init()
    var name: String = ""

    
}
