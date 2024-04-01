//
//  RKMaterial.swift
//  Swift3D
//
//  Created by lingji zhou on 3/29/24.
//

import Foundation
import Metal

protocol RKMaterial {
    var vertexShader: MaterialFunction { get }
    var fragmentShader: MaterialFunction { get }
    var texture: Texture? { get }
}

struct Texture {
    let resource: TextureResource
    let sampler: MTLSamplerDescriptor
}

struct MaterialParameters {

}

protocol MaterialFunction {
    var name: String { get }
    var library: any MTLLibrary { get }
}
