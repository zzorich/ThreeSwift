//
//  Renderer.swift
//  Swift3D
//
//  Created by lingji zhou on 3/26/24.
//

import Foundation
import Metal
import MetalKit

class Renderer: MTKViewDelegate {
    private let drawableRenderPipieline: MTLRenderPipelineState
    private var aspectRatio: Float
    private let device: MTLDevice
    private let commandQueue: MTLCommandQueue
    private let pipelineDescriptor: MTLRenderPipelineDescriptor


    init(mtkView: MTKView) {
        if mtkView.device == nil { mtkView.device = MTLCreateSystemDefaultDevice() }
        self.device = mtkView.device!

        self.commandQueue = device.makeCommandQueue()!
        let defaultLibrary = device.makeDefaultLibrary()!
        self.pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.label = "Main Pipline"
        pipelineDescriptor.rasterSampleCount = mtkView.sampleCount
        pipelineDescriptor.colorAttachments[0].pixelFormat = mtkView.colorPixelFormat
        aspectRatio = 1.0
    }


    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        aspectRatio = Float(size.height / size.width)
    }

    func draw(in view: MTKView) {

    }


    func draw(node: Node) {
        
    }
}
