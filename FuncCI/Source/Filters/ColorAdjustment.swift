//
//  ColorAdjustment.swift
//  FuncCI
//
//  Created by Chris M on 1/5/16.
//  Copyright © 2016 Christopher Manahan. All rights reserved.
//

import UIKit

typealias RGBAVector = Vector4
typealias ColorVector = Vector4

struct ColorAdjustment: FilterType {
    
    /**
     Modifies color values to keep them within a specified range.
     At each pixel, color component values less than those in inputMinComponents will be increased to match those in inputMinComponents, and color component values greater than those in inputMaxComponents will be decreased to match those in inputMaxComponents.
     
     - parameter min: RGBA values for the lower end of the range
     - parameter max: RGBA values for the higher end of the range
     
     - returns: Filter
     */
    static func clamp(minComponents min: RGBAVector, maxComponents max: RGBAVector) -> Filter {
        return self.createFilter(
            "CIColorClamp",
            params: [
                "inputMinComponents": CIVector(x: min.0, y: min.1, z: min.2, w: min.3),
                "inputMaxComponents": CIVector(x: max.0, y: max.1, z: max.2, w: max.3)
            ]
        )
    }
    
    /**
     Adjusts saturation, brightness, and contrast values.
     
     - parameter saturation: Input saturation
     - parameter brightness: Input brightness
     - parameter contrast:   Input contrast
     
     - returns: Filter
     */
    static func controls(saturation: Double = 1.0, brightness: Double = 1.0, contrast: Double = 1.0) -> Filter {
        return self.createFilter(
            "CIColorControls",
            params: [
                kCIInputSaturationKey: saturation,
                kCIInputBrightnessKey: brightness,
                kCIInputContrastKey: contrast
            ]
        )
    }
    
    /**
     Multiplies source color values and adds a bias factor to each color component.
     
     - parameter r:    Red vector
     - parameter g:    Green vector
     - parameter b:    Blue vector
     - parameter a:    Alpha vector
     - parameter bias: Bias vector
     
     - returns: Filter
     */
    static func matrix(red r: ColorVector = (1,0,0,0), green g: ColorVector = (0,1,0,0), blue b: ColorVector = (0,0,1,0), alpha a: ColorVector = (0,0,0,1), bias: ColorVector = (0,0,0,0)) -> Filter {
        return self.createFilter(
            "CIColorMatrix",
            params: [
                "inputRVector": CIVector.fromVector(r),
                "inputGVector": CIVector.fromVector(g),
                "inputBVector": CIVector.fromVector(b),
                "inputAVector": CIVector.fromVector(a),
                "inputBiasVector": CIVector.fromVector(bias)
            ]
        )
    }
    
    /**
     Modifies the pixel values in an image by applying a set of cubic polynomials.
     For each pixel, the value of each color component is treated as the input to a cubic polynomial, whose coefficients are taken from the corresponding input coefficients parameter in ascending order. Equivalent to the following formula:
     
     - parameter r: Red coefficients
     - parameter g: Green coefficients
     - parameter b: Blue coefficients
     - parameter a: Alpha coefficients
     
     - returns: Filter
     */
    static func polynomial(red r: ColorVector = (0,1,0,0), green g: ColorVector = (0,1,0,0), blue b: ColorVector = (0,1,0,0), alpha a: ColorVector = (0,1,0,0)) -> Filter {
        return self.createFilter(
            "CIColorPolynomial",
            params: [
                "inputRedCoefficients": CIVector.fromVector(r),
                "inputGreenCoefficients": CIVector.fromVector(g),
                "inputBlueCoefficients": CIVector.fromVector(b),
                "inputAlphaCoefficients": CIVector.fromVector(a),
            ])
    }
    
    /**
     Adjusts the exposure setting for an image similar to the way you control exposure for a camera when you change the F-stop.
     This filter multiplies the color values to simulate exposure change by the specified F-stops
     
     - parameter ev: Exposure
     
     - returns: Filter
     */
    static func exposureAdjust(exposure ev: Double = 0.50) -> Filter {
        return self.createFilter(
            "CIExposureAdjust",
            params: [
                kCIInputEVKey: ev
            ]
        )
    }
    
    /**
     Adjusts midtone brightness.
     This filter is typically used to compensate for nonlinear effects of displays. Adjusting the gamma effectively changes the slope of the transition between black and white.
     
     - parameter power: Input power
     
     - returns: Filter
     */
    static func gammaAdjust(power: Double = 0.75) -> Filter {
        return self.createFilter(
            "CIGammaAdjust",
            params: [
                "inputPower": power
            ]
        )
    }
    
    /**
     Changes the overall hue, or tint, of the source pixels.
     
     - parameter angle: Angle
     
     - returns: Filter
     */
    static func hueAdjust(angle: Double = 0.0)  -> Filter {
        return self.createFilter(
            "CIHueAdjust",
            params: [
                kCIInputAngleKey: angle
            ]
        )
    }

    /**
     Maps color intensity from the sRGB color space to a linear gamma curve.
     
     - returns: Filter
     */
    static func linearToSRGBToneCurve() -> Filter {
        return self.createFilter("CISRGBToneCurveToLinear", params: nil)
    }
    
    /**
     Adapts the reference white point for an image.
     
     - parameter neutral:       Neutral vector
     - parameter targetNeutral: Target neutral vector
     
     - returns: Filter
     */
    static func temperatureAndTint(neutral neutral: Vector2 = (6500,0), targetNeutral: Vector2 = (6500,0)) -> Filter {
        return self.createFilter(
            "CITemperatureAndTint",
            params: [
                "inputNeutral": CIVector.fromVector(neutral),
                "inputTargetNeatral": CIVector.fromVector(targetNeutral)
            ]
        )
    }
    
    /**
     Adjusts tone response of the R, G, and B channels of an image.
     
     - returns: Filter
     */
    static func toneCurve(pt0: Vector2 = (0,0), pt1: Vector2 = (0.25,0.25), pt2: Vector2 = (0.5,0.5), pt3: Vector2 = (0.75,0.75), pt4: Vector2 = (1.0,1.0)) -> Filter {
        return self.createFilter(
            "CIToneCurve",
            params: [
                "inputPoint0": CIVector.fromVector(pt0),
                "inputPoint1": CIVector.fromVector(pt1),
                "inputPoint2": CIVector.fromVector(pt2),
                "inputPoint3": CIVector.fromVector(pt3),
                "inputPoint4": CIVector.fromVector(pt4),
            ]
        )
    }
    
    /**
     Adjusts the saturation of an image while keeping pleasing skin tones.
     
     - parameter amount: Amount
     
     - returns: Filter
     */
    static func vibrance(amount: Double) -> Filter {
        return self.createFilter(
            "CIVibrance",
            params: [
                "inputAmount": amount
            ]
        )
    }
    
    /**
     Adjusts the reference white point for an image and maps all colors in the source using the new reference.
     
     - parameter color: Color to use as white ref point
     
     - returns: Filter
     */
    static func whitePointAdjust(color: UIColor) -> Filter {
        return self.createFilter(
            "CIWhitePointAdjust",
            params: [
                kCIInputColorKey: CIColor(color: color)
            ]
        )
    }
}
