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
        static let collectionViewCellHeight: CGFloat = 60
        static let sideContentInset: CGFloat = 10
        static let topContentInset: CGFloat = 10
        static let interItemSpacing: CGFloat = 10
        static let reusableViewHeightOffset: CGFloat = 30
        
        static let cornerRadius: CGFloat = 10
    }
    
    // MARK: - Properties
    
    var files: [DropboxFile] = []
    var currentFolderName = String()
    private var itemWidth: CGFloat {
        return collectionView.bounds.width - Constants.sideContentInset * 2
    }
    private var itemHeight: CGFloat = Constants.collectionViewCellHeight
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var currentFolderNameLabel: UILabel!
    
    // MARK: - Actions
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {} // TODO
    @IBAction func didPressBackButton(_ sender: UIButton) {} //TODO
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapToEnterFolder))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        self.collectionView.addGestureRecognizer(doubleTapGestureRecognizer)
        
        currentFolderNameLabel.text = currentFolderName
        collectionView.makeRoundedCorners(cornerRadius: Constants.cornerRadius)
        collectionView.contentInset.top = Constants.topContentInset
        collectionView.contentInset.left = Constants.sideContentInset
        collectionView.contentInset.right = Constants.sideContentInset
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing = Constants.interItemSpacing
    }
    
    // MARK: - Auxiliary Methods
    
    func presentFolder(folder: DropboxFile) {
        guard let fileDisplayViewController = self.storyboard?.instantiateViewController(withIdentifier: "fileDisplayViewController") as? DropboxFileDisplayViewController else {
            fatalError("could not create view controller")
        }
        fileDisplayViewController.files = folder.containingFiles
        fileDisplayViewController.currentFolderName = folder.fileName
        self.present(fileDisplayViewController, animated: false, completion: nil)
    }
    
    func getDropboxFile(at indexPath: IndexPath) -> DropboxFile {
        return files[indexPath.row]
    }
    
    @objc func didDoubleTapToEnterFolder(_ sender: UITapGestureRecognizer) {
        let pointInCollectionView = sender.location(in: self.collectionView)
        guard let selectedIndexPath = self.collectionView.indexPathForItem(at: pointInCollectionView) else {
            fatalError("could not retrieve index path")
        }
        guard let selectedCell = self.collectionView.cellForItem(at: selectedIndexPath) as? DropboxFileCollectionViewCell else {
            fatalError("could not get cell")
        }
        let fileForCurrentCell = getDropboxFile(at: selectedIndexPath)
        if fileForCurrentCell.isFolder {
            presentFolder(folder: fileForCurrentCell)
        }
        
        print("selected folder \(String(describing: selectedCell.fileNameLabel.text))")
    }
}

extension DropboxFileDisplayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return files.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? DropboxFileCollectionViewCell else {
            fatalError("Could not get cell")
        }
        cell.populateWith(dropboxFile: files[indexPath.item])
        cell.makeRoundedCorners(cornerRadius: Constants.cornerRadius)
        cell.dropShadow()
        
        return cell
    }
}

extension DropboxFileDisplayViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
