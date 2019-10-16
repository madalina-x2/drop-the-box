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

    @IBAction func connectViaDropboxButtonPressed(_ sender: UIButton) {
        DropboxClientsManager.authorizeFromController(UIApplication.shared,
        controller: self,
        openURL: { (url: URL) -> Void in
          UIApplication.shared.openURL(url)
        })
    }
}

