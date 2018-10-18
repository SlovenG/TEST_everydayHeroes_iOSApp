//
//  ScoringTableViewCell.swift
//  testEverydayHeroes
//
//  Created by Sloven Graciet on 17/10/2018.
//  Copyright © 2018 sloven Graciet. All rights reserved.
//

import UIKit

class ScoringTableViewCell: UITableViewCell {
    
    @IBOutlet weak var scoringLabel: UILabel!
    
    @IBOutlet weak var heartStackView: UIStackView!
    
    @IBOutlet weak var awardMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
