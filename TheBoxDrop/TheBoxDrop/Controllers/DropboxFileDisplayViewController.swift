//
//  DropboxFileDisplayViewController.swift
//  TheBoxDrop
//
//  Created by Madalina Sinca on 17/10/2019.
//  Copyright © 2019 Madalina Sinca. All rights reserved.
//

import UIKit

class DropboxFileDisplayViewController: UIViewController {
    
    var files = [DropboxFile]()

    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func logOutButtonPressed(_ sender: UIButton) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
