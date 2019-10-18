//
//  DropboxFileCollectionViewCell.swift
//  TheBoxDrop
//
//  Created by Madalina Sinca on 17/10/2019.
//  Copyright © 2019 Madalina Sinca. All rights reserved.
//

import UIKit

class DropboxFileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var fileIconImageView: UIImageView!
    
    func populateWith(dropboxFile: DropboxFile) {
        fileNameLabel.text = dropboxFile.fileName
        if dropboxFile.isFolder {
            fileIconImageView.image = #imageLiteral(resourceName: "image_icon")
        } else {
            fileIconImageView.image = #imageLiteral(resourceName: "document_icon")
        }
    }
    
}
