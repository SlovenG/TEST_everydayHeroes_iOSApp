//
//  AnswerTableViewCell.swift
//  testEverydayHeroes
//
//  Created by Sloven Graciet on 17/10/2018.
//  Copyright © 2018 sloven Graciet. All rights reserved.
//

import UIKit

protocol AnswerTableViewCellDelegate: class{
    func didEndPlan(_ sender: AnswerTableViewCell)
}

class AnswerTableViewCell: UITableViewCell {
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    
    weak var delegate: AnswerTableViewCellDelegate?
    var answer: (String,Bool)!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     
        if selected{
            if self.answer.1 == true {
                self.backgroundImg.image = UIImage(named: "backgroundCorrect")
                self.isUserInteractionEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { 
                    self.delegate?.didEndPlan(self)
                }
            }
            else{
                self.backgroundImg.image = UIImage(named: "backgroundFalse")
            }
        }
        
        
        
    }
    
    func initCell(answer: (String,Bool)){
        self.answer = answer
        
        self.answerLabel.text = answer.0
        self.answerLabel.textColor = .black
        
        self.backgroundImg.image = UIImage(named: "backgroundUnselected")
    }
    

}
