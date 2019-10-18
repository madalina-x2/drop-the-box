//
//  DropboxFileDisplayViewController.swift
//  TheBoxDrop
//
//  Created by Madalina Sinca on 17/10/2019.
//  Copyright © 2019 Madalina Sinca. All rights reserved.
//

import UIKit

private let reuseIdentifier = "dropboxFileCell"

class DropboxFileDisplayViewController: UIViewController {
    
    // MARK: - Constants
    
    struct Constants {
        static let collectionViewCellHeight: CGFloat = 80
        static let sideContentInset: CGFloat = 10
        static let interItemSpacing: CGFloat = 10
        static let reusableViewHeightOffset: CGFloat = 30
        
        static let cornerRadius: CGFloat = 10
    }
    
    // MARK: - Properties
    
    var files = [DropboxFile]()
    private var itemWidth: CGFloat {
        return view.bounds.width - Constants.sideContentInset * 2
    }
    private var itemHeight: CGFloat = Constants.collectionViewCellHeight
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func logOutButtonPressed(_ sender: UIButton) {} // TODO
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInset.left = Constants.sideContentInset
        collectionView.contentInset.right = Constants.sideContentInset
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing = Constants.interItemSpacing
    }
}
