//
//  DropboxFile.swift
//  TheBoxDrop
//
//  Created by Madalina Sinca on 17/10/2019.
//  Copyright © 2019 Madalina Sinca. All rights reserved.
//

import Foundation
import SwiftyDropbox

class DropboxFile {
    
    // MARK: - Properties
    
    var fileName: String!
    var isFolder: Bool!
    var nestingLevel: Int!
    var parentNames: [String]! = []
    var containingFiles: [DropboxFile] = []
    
    // MARK: - Initializers
    
    init(from file: Files.Metadata) {
        self.fileName = file.name.lowercased()
        
        if file is Files.FolderMetadata {
            self.isFolder = true
        } else {
            self.isFolder = false
        }
        
        self.nestingLevel = computeNestingLevel(from: file.pathLower!.lowercased())
    }
    
    // MARK: - Auxiliary Methods
    
    func computeNestingLevel(from path: String) -> Int {
        if path == "/" + self.fileName {
            return 0
        } else {
            var currentPath = path.trimLastItem()
            while currentPath != "" {
                let currentParentName = currentPath.extractLastItem()
                currentPath = currentPath.trimLastItem()
                self.parentNames.append(currentParentName)
            }
        }
        return self.parentNames.count
    }
}
