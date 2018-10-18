//
//  Plans.swift
//  testEverydayHeroes
//
//  Created by Sloven Graciet on 17/10/2018.
//  Copyright © 2018 sloven Graciet. All rights reserved.
//

import Foundation

enum info: String {
    case advice = "InfoTableViewCell"
    case resume = "ResumeTableViewCell"
}

class Plans {
    
    var ask :NSMutableAttributedString!
    var answers: [(String, Bool)]!
    var isMultipleAnswers: Bool = false
    var isViewedMutlipleInfo: Bool = false
    var infoMessage: info!
    var firefighterMessage: Bool = true
    var isLastPlan : Bool = false
    
    
}
