//
//  MultipleChoicesTableViewCell.swift
//  testEverydayHeroes
//
//  Created by Sloven Graciet on 17/10/2018.
//  Copyright © 2018 sloven Graciet. All rights reserved.
//

import UIKit

protocol  MultipleChoicesTableViewCellDelegate: class{
    func didCloseInfoMultiple(_ sender:MultipleChoicesTableViewCell)
}

class MultipleChoicesTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    
    weak var delegate: MultipleChoicesTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.layer.cornerRadius = 10
        cardView.addShadow()
    }
    
    @IBAction func didTapedCloseInfoMultiple(_ sender: Any) {
        delegate?.didCloseInfoMultiple(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
