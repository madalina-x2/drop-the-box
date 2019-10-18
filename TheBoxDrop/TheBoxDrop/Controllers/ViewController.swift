//
//  ViewController.swift
//  TheBoxDrop
//
//  Created by Madalina Sinca on 16/10/2019.
//  Copyright © 2019 Madalina Sinca. All rights reserved.
//

import UIKit
import SwiftyDropbox

class ViewController: UIViewController {
    
    var dropboxFiles: [DropboxFile] = []
    var readyToDisplayFiles: Bool = false {
        didSet {
            guard let fileDisplayViewController = self.storyboard?.instantiateViewController(withIdentifier: "fileDisplayViewController") as? DropboxFileDisplayViewController else {
                fatalError("could not create view controller")
            }
            fileDisplayViewController.files = dropboxFiles
            self.present(fileDisplayViewController, animated: false, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let client = DropboxClientsManager.authorizedClient {
            
            _ = client.files.listFolder(path: "", recursive: true).response(completionHandler: { (response, error) in
                if let result = response {
                    //print("Folder Contents: \(result.entries)")
                    
                    for entry in result.entries {
                        let dropboxFile = DropboxFile(from: entry)
                        self.dropboxFiles.append(dropboxFile)
                    }
                    
                    self.dropboxFiles = self.dropboxFiles.sortInDecreasingOrder(by: \.nestingLevel)
                    
                    for dropboxFile in self.dropboxFiles {
                        guard let parentName = dropboxFile.parentNames.first else {
                            break
                        }
                        guard let parent = self.dropboxFiles.first(where: { $0.fileName == parentName}) else {
                            break
                        }
                        
                        parent.containingFiles.append(dropboxFile)

                    }
                    
                    self.dropboxFiles = self.dropboxFiles.filter( { $0.nestingLevel == 0 } )
                    
                    self.readyToDisplayFiles = true
                } else {
                    print("Error: \(error!)")
                }
            })
        }
    }
    
    @IBAction func connectViaDropboxButtonPressed(_ sender: UIButton) {
        DropboxClientsManager.authorizeFromController(UIApplication.shared,
                                                      controller: self,
                                                      openURL: { (url: URL) -> Void in
                                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        })
    }
}

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

extension Array {
    func sortInDecreasingOrder<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { a, b in
            return a[keyPath: keyPath] > b[keyPath: keyPath]
        }
    }
}

