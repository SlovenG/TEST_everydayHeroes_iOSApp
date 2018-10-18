//
//  EndSceneViewController.swift
//  testEverydayHeroes
//
//  Created by Sloven Graciet on 17/10/2018.
//  Copyright © 2018 sloven Graciet. All rights reserved.
//

import UIKit



enum sceneState {
    case redo
    case next
    case score
}
protocol EndSceneViewControllerDelegate : class {
    func popOut(state: sceneState)
}

class EndSceneViewController: UIViewController {

    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var heightShadowConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var hexaHeaderImg: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var leftFooterButton: UIButton!
    @IBOutlet weak var rightFooterButton: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: EndSceneViewControllerDelegate?

    
    var resumeTitle: String!
    var currentPlan: Plans!
    var isEndScene: Bool = false
    
    var anchor : position = .top
    
    enum position: CGFloat {
        case top = 37
        case bottom = 270
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        initHeader()
        initButton()
        contentView.layer.cornerRadius = 5
        
        //Register tableViewCells
        self.tableView.register(UINib(nibName: "FirefighterInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "FirefighterInfoTableViewCell")
        self.tableView.register(UINib(nibName: "InfoTableViewCell", bundle: nil),
            forCellReuseIdentifier: "InfoTableViewCell")
        self.tableView.register(UINib(nibName: "ResumeTableViewCell", bundle: nil),
            forCellReuseIdentifier: "ResumeTableViewCell")
        self.tableView.register(UINib(nibName: "ScoringTableViewCell", bundle: nil),
            forCellReuseIdentifier: "ScoringTableViewCell")
        
        
    }
    
    func initHeader(){
        if isEndScene {
            self.headerLabel.text = "Félicitations!"
        }
        else if currentPlan.infoMessage == .resume {
            self.headerLabel.text = "Résumé"
        } else {
            self.headerLabel.text = "Bonne Réponse!"
        }
        self.heightShadowConstraint.constant = anchor.rawValue
        
        let rocketLabel = UILabel()
        rocketLabel.text = "🚀"
        rocketLabel.frame = CGRect(x: 13, y: 13, width: 30, height: 39)
        rocketLabel.font = UIFont(name: "AppleColorEmoji", size: 30)

        self.hexaHeaderImg.addSubview(rocketLabel)
    }
    
    func initButton(){
        self.leftFooterButton.isHidden = false
        if self.isEndScene {
            self.leftFooterButton.setTitle("Thème", for: .normal)
            self.leftFooterButton.addTarget(self, action: #selector(self.didTapedHome(_:)), for: .touchUpInside)

            
            self.rightFooterButton.setTitle("Mes entrainements", for: .normal)
            self.rightFooterButton.addTarget(self, action: #selector(self.didTapedHome(_:)), for: .touchUpInside)

        } else if currentPlan.isLastPlan {
            self.leftFooterButton.isHidden = true
            
            self.rightFooterButton.setTitle("Découvrir mon score", for: .normal)
            self.rightFooterButton.addTarget(self, action: #selector(self.didTapedScoring(_:)), for: .touchUpInside)
        }
        else {
            self.leftFooterButton.titleLabel?.text = nil
            self.leftFooterButton.imageView?.contentMode = .scaleAspectFit
            self.leftFooterButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            self.leftFooterButton.setImage(UIImage(named: "redo"), for: .normal)
            self.leftFooterButton.addTarget(self, action: #selector(self.didTapedRedo(_:)), for: .touchUpInside)
            
            self.rightFooterButton.setTitle("Etape suivante", for: .normal)
            self.rightFooterButton.addTarget(self, action: #selector(self.didTapedNext(_:)), for: .touchUpInside)

        }
        
    }
    
    @objc func didTapedNext(_ sender: UIButton) {
        self.delegate?.popOut(state: .next)
        self.dismiss(animated: true, completion: nil)
    }

    @objc func didTapedRedo(_ sender: UIButton) {
         self.delegate?.popOut(state: .redo)
        self.dismiss(animated: true,  completion: nil)
       
    }
    
    @objc func didTapedScoring(_ sender: UIButton) {
        self.anchor = .bottom
        self.isEndScene = true
        self.viewDidLoad()
    }
    
    @objc func didTapedHome(_ sender: UIButton) {
        performSegue(withIdentifier: "backHome", sender: self)
    }
}

extension EndSceneViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isEndScene{
            return 1
        }
        else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            if self.isEndScene {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "ScoringTableViewCell", for: indexPath) as? ScoringTableViewCell {
                    return cell
                }
            }
            if currentPlan.infoMessage == .advice {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as? InfoTableViewCell {
                    return cell
                }
            }
            else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "ResumeTableViewCell", for: indexPath) as? ResumeTableViewCell {
                    return cell
                }
            }
        case 1 :
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FirefighterInfoTableViewCell", for: indexPath) as? FirefighterInfoTableViewCell {
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    
    ///!!!!!!
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            if isEndScene {
                return 200
            } else if currentPlan.infoMessage == .advice {
                return 265
            } else {
                return 380
            }
        case 1:
            return 120
        default:
            return 140
        }
    }
}

