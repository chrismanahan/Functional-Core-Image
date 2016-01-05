//
//  Blur.swift
//  FuncCI
//
//  Created by Chris M on 1/4/16.
//  Copyright © 2016 Christopher Manahan. All rights reserved.
//

import UIKit

struct Blur: FilterType {
    /**
     Blurs an image using a box-shaped convolution kernel.
     
     - parameter radius: Radius of the blur
     
     - returns: Filter
     */
    static func boxBlur(radius: Double = 10) -> Filter {
        return blur("Box", radius: radius)
    }
    
    /**
     Blurs an image using a disc-shaped convolution kernel.
     
     - parameter radius: Radius of the blur
     
     - returns: Filter
     */
    static func discBlur(radius: Double) -> Filter {
        return blur("Disc", radius: radius)
    }
    
    /**
     Spreads source pixels by an amount specified by a Gaussian distribution.
     
     - parameter radius: Radius of the blur
     
     - returns: Filter
     */
    static func gaussianBlur(radius: Double) -> Filter {
        return blur("Gaussian", radius: radius)
    }
    
    /**
     Blurs an image to simulate the effect of using a camera that moves a specified angle and distance while capturing the image.
     
     - parameter radius: Radius of the blur
     
     - returns: Filter
     */
    static func motionBlur(radius: Double = 20.0, angle: Double = 0.0) -> Filter {
        return self.createFilter(
            "CIMotionBlur",
            params: [
                kCIInputRadiusKey: radius,
                kCIInputAngleKey: angle
            ])
    }
    
    /**
     Blurs an image using a box-shaped convolution kernel.
     
     - parameter radius: Radius of the blur
     
     - returns: Filter
     */
    static func zoomBlur(radius: Double) -> Filter {
        return blur("Zoom", radius: radius)
    }
    
    /**
     Blurs the source image according to the brightness levels in a mask image.
     
     - parameter radius: Radius of the blur
     - parameter mask: Image to be used as mask
     
     - returns: Filter
     */
    static func maskedVariableBlur(radius: Double = 10.0, mask: CIImage) -> Filter {
        return self.createFilter(
            "CIMaskedVariableBlur",
            params: [
                kCIInputRadiusKey: radius,
                kCIInputMaskImageKey: mask
            ])
    }
    
    /**
     Blurs an image using a box-shaped convolution kernel.
     
     - parameter radius: Radius of the blur
     
     - returns: Filter
     */
    static func noiseReduction(noiseLevel: Double = 0.02, sharpness: Double = 0.40) -> Filter {
        return self.createFilter("CINoiseReduction",
            params: [
                "inputNoiseLevel": noiseLevel,
                kCIInputSharpnessKey: sharpness
            ])
    }
    
    /**
     Computes the median value for a group of neighboring pixels and replaces each pixel value with the median.
     
     - returns: Filter
     */
    static func medianFilter() -> Filter {
        return self.createFilter("CIMedianFilter", params: nil)
    }
}

extension Blur {
    /**
     Convenience function that creates a filter that has the format CI<name>Blur
     
     - parameter name:   Name of blur filter
     - parameter radius: Radius of blur
     
     - returns: Filter
     */
    private static func blur(name: String, radius: Double) -> Filter {
        return self.createFilter(
            "CI\(name)Blur",
            params: [kCIInputRadiusKey: radius])
    }
}
