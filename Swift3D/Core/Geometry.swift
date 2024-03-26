//
//  SCNGeometry.swift
//  Swift3D
//
//  Created by lingji zhou on 3/17/24.
//

import Foundation

class Geometry {
    var sources: [GeometrySource]
    var elements: [GeometryElement]
    init(sources: [GeometrySource], elements: [GeometryElement]) {
        self.sources = sources
        self.elements = elements
    }
}
