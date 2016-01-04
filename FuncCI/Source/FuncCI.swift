//
//  FuncCI.swift
//  FuncCI
//
//  Created by Chris M on 1/4/16.
//  Copyright © 2016 Christopher Manahan. All rights reserved.
//

import UIKit

typealias Filter = CIImage -> CIImage


class FuncCI {
    
    // MARK: - Filters
    // MARK: Blur
    class func blur(radius: Double) -> Filter {
        return { image in
            return self.imageFor(
                "CIGaussianBlur",
                params: [kCIInputRadiusKey: radius],
                image: image
            )
        }
    }
    
    class func mask(overlay: UIImage) -> Filter {
        return { image in
            return self.imageFor(
                "CIBlendWithAlphaMask",
                params: [kCIInputMaskImageKey: CIImage(image: overlay)!],
                image: image
            )
        }
    }
    
    class func monochrome(color: UIColor, intensity: Double = 1.0) -> Filter {
        return { image in
            return self.imageFor(
                "CIColorMonochrome",
                params: [
                    kCIInputColorKey: CIColor(color: color),
                    kCIInputIntensityKey: intensity,
                ],
                image: image)
        }
    }
    
    class func vignette(radius: Double, intensity: Double = 1.0) -> Filter {
        return { image in
            return self.imageFor(
                "CIVignette",
                params: [
                    kCIInputRadiusKey: radius,
                    kCIInputIntensityKey: intensity
                ],
                image: image
            )
        }
    }
    
    // BUG: this doesn't seem to work
//    func colorGenerator(color: UIColor) -> Filter {
//        return { _ in
//            let params = [kCIInputColorKey: CIColor(color: color)]
//            let filter = CIFilter(name: "CIConstantColorGenerator", withInputParameters: params)
//            let image = filter!.outputImage!
//            return image
//        }
//    }
//    
//    func compositeSourceOver(overlay: CIImage) -> Filter {
//        return { image in
//            let params = [
//                kCIInputBackgroundImageKey: image,
//                kCIInputImageKey: overlay
//            ]
//            let filter = CIFilter(name: "CISourceOverCompositing", withInputParameters: params)
//            let cropRect = image.extent
//            return filter!.outputImage!.imageByCroppingToRect(cropRect)
//        }
//    }
//    
//    func colorOverlay(color: UIColor) -> Filter {
//        return { [unowned self] image in
//            let overlay = self.colorGenerator(color)(image)
//            return self.compositeSourceOver(overlay)(image)
//        }
//    }
//    
    // MARK: - Private
    private class func imageFor(filterName: String, var params: [String: AnyObject]?, image: CIImage) -> CIImage {
        if params == nil {
            params = [:]
        }
        params![kCIInputImageKey] = image
        
        let filter = CIFilter(name: filterName, withInputParameters: params)
        return filter!.outputImage!
    }
}

infix operator >>> { associativity left }
func >>> (filter1: Filter, filter2: Filter) -> Filter {
    return { image in filter2(filter1(image)) }
}

