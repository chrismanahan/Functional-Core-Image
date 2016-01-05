//
//  Extensions.swift
//  FuncCI
//
//  Created by Chris M on 1/4/16.
//  Copyright © 2016 Christopher Manahan. All rights reserved.
//

import UIKit

extension UIColor {
    class func sepiaColor() -> UIColor { return UIColor(red: 0.76, green: 0.65, blue: 0.54, alpha: 1.0) }
}

struct Context {
    static var shared: CIContext?
    static func get() -> CIContext {
        if shared == nil {
            shared = CIContext(options: nil)
        }
        return shared!
    }
    
}

extension CIImage {
    func uiImage(rect: CGRect? = nil) -> UIImage {
        let ctx = Context.get()
        let cgImage = ctx.createCGImage(self, fromRect: rect ?? self.extent)
        return UIImage(CGImage: cgImage)
    }
}


typealias Vector2 = (CGFloat, CGFloat)
typealias Vector3 = (CGFloat, CGFloat, CGFloat)
typealias Vector4 = (CGFloat, CGFloat, CGFloat, CGFloat)

extension CIVector {
   
    static func fromVector(vector: Vector2) -> CIVector {
        return CIVector(x: vector.0, y: vector.1)
    }
    
    static func fromVector(vector: Vector3) -> CIVector {
        return CIVector(x: vector.0, y: vector.1, z: vector.2)
    }
    
    static func fromVector(vector: Vector4) -> CIVector {
        return CIVector(x: vector.0, y: vector.1, z: vector.2, w: vector.3)
    }
}