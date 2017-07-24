//
//  MyCustomCell.swift
//  PersistentExampleService
//
//  Created by Stanly Shiyanovskiy on 24.07.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

class MyCustomCell: UITableViewCell {
    
    @IBOutlet var img: UIImageView!
    @IBOutlet var titleCell: UILabel!
    @IBOutlet var idCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureCell(mitre: Mitre) {
        titleCell.text = mitre.title
        idCell.text = "\(mitre.id)"
        if let imgData = mitre.img {
            img.image = UIImage(data: (imgData as Data?)!)
        }
    }
}
