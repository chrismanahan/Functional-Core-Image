//
//  FuncCI.swift
//  FuncCI
//
//  Created by Chris M on 1/4/16.
//  Copyright © 2016 Christopher Manahan. All rights reserved.
//

import UIKit

typealias Filter = CIImage -> CIImage

/**
 *  Defines a type that can create filters
 */
protocol FilterType {
    /**
     Creates a filter from the CoreImage filter name and it's parameters
     
     - parameter name:   Name of filter
     - parameter params: Parameters for filter
     
     - returns: Filter
     */
    static func createFilter(name: String, var params: [String: AnyObject]?) -> Filter
    
    /**
     Creates an empty filter. This can be used as a starting point to reduce a collection of filters
     */
    static func createEmptyFilter() -> Filter
}

extension FilterType {
    static func createFilter(name: String, var params: [String: AnyObject]?) -> Filter {
        return { image in
            if params == nil {
                params = [:]
            }
            params![kCIInputImageKey] = image
            
            let filter = CIFilter(name: name, withInputParameters: params)
            return filter!.outputImage!
        }
    }
    
    static func createEmptyFilter() -> Filter {
        return { return $0 }
    }
}

struct BaseFilter: FilterType {
  
}

infix operator >>> { associativity left }
func >>> (filter1: Filter, filter2: Filter) -> Filter {
    return { image in filter2(filter1(image)) }
}

