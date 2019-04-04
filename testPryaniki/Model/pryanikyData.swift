//
//  pryanikiData.swift
//  testPryaniki
//
//  Created by Ilya Abdullin on 04/04/2019.
//  Copyright © 2019 Ilya Abdullin. All rights reserved.
//

import Foundation

struct Pryaniky: Codable {
    let data: [PryanikyData]
    let view: [String]
    
    func getData(by viewName: String) -> PryanikyData? {
        for curItem in data {
            if curItem.name == viewName {
                return curItem
            }
        }
        
        return nil
    }
}

struct PryanikyData: Codable {
    let name: String
    let data: PryanikySimpleData
    
    func getSelectedVariant() -> PryanikySimpleDataSelectorVariants? {
        if let selectedId = data.selectedId, let variants = data.variants {
            for variant in variants {
                if variant.id == selectedId {
                    return variant
                }
            }
        }
        
        return nil
    }
    
    func getVariantValues() -> [String]? {
        if let variants = data.variants {
            var variantValues = [String]()
            
            for variant in variants {
                variantValues.append(variant.text)
            }
            
            return variantValues
        }
        
        return nil
    }
    
    func getIndexForSelectedVariant() -> Int? {
        if let selectedVariantText = getSelectedVariant()?.text {
            return getVariantValues()?.firstIndex(of: selectedVariantText)
        }
        
        return nil
    }
}

struct PryanikySimpleData: Codable {
    let text: String?
    let url: String?
    let selectedId: Int?
    let variants: [PryanikySimpleDataSelectorVariants]?
}

struct PryanikySimpleDataSelectorVariants: Codable {
    let id: Int
    let text: String
}
