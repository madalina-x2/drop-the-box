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
    
    // MARK: - Properties
    
    var dropboxFiles: [DropboxFile] = []
    var readyToDisplayFiles: Bool = false {
        didSet {
            guard let fileDisplayViewController = self.storyboard?.instantiateViewController(withIdentifier: "fileDisplayViewController") as? DropboxFileDisplayViewController else {
                fatalError("could not create view controller")
            }
            fileDisplayViewController.files = dropboxFiles
            fileDisplayViewController.currentFolderName = "Dropbox root folder"
            self.present(fileDisplayViewController, animated: false, completion: nil)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func connectViaDropboxButtonPressed(_ sender: UIButton) {
        DropboxClientsManager.authorizeFromController(UIApplication.shared,
                                                      controller: self,
                                                      openURL: { (url: URL) -> Void in
                                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        })
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let client = DropboxClientsManager.authorizedClient {
            fetchFiles(from: client)
        }
    }
    
    // MARK: - Auxiliary Methods
    
    func fetchFiles(from client: DropboxClient) {
        _ = client.files.listFolder(path: "", recursive: true).response(completionHandler: { (response, error) in
            guard let result = response else {
                print("Error: \(error!)")
                return
            }
            
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
        })
    }
}

