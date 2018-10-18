//
//  FirefighterInfoTableViewCell.swift
//  testEverydayHeroes
//
//  Created by Sloven Graciet on 17/10/2018.
//  Copyright © 2018 sloven Graciet. All rights reserved.
//

import UIKit

class FirefighterInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firefighterImg: UIImageView!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let imageName = "fireFighterIllustration"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 3, y: 10, width: 70.4, height: 77.8)
        imageView.contentMode = .scaleAspectFit
        self.firefighterImg.insertSubview(imageView, aboveSubview:self.firefighterImg)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
