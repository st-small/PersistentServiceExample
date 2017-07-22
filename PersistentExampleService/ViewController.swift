//
//  ViewController.swift
//  PersistentExampleService
//
//  Created by Stanly Shiyanovskiy on 22.07.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PersistentService.getListOfItems()
    }
}

