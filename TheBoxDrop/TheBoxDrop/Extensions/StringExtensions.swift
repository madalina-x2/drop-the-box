//
//  StringExtensions.swift
//  TheBoxDrop
//
//  Created by Madalina Sinca on 18/10/2019.
//  Copyright © 2019 Madalina Sinca. All rights reserved.
//

import Foundation

extension String {
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespaces() -> String {
        return self.replace(string: " ", replacement: "")
    }
    
    func trimLastItem() -> String {
        guard let trimmingIndex = self.lastIndex(of: "/"), self.lastIndex(of: "/") != self.startIndex else {
            return ""
        }
        let range = self.startIndex..<trimmingIndex
        return String(self[range])
    }
    
    func extractLastItem() -> String {
        let extractionIndex = self.lastIndex(of: "/")!
        let range = index(after: extractionIndex)..<self.endIndex
        
        return String(self[range])
    }
}
