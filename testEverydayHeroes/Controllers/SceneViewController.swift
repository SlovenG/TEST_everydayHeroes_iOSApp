//
//  SceneViewController.swift
//  testEverydayHeroes
//
//  Created by Sloven Graciet on 16/10/2018.
//  Copyright © 2018 sloven Graciet. All rights reserved.
//

import UIKit

class SceneViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var topImage: UIImageView!
    
    @IBOutlet weak var progressBar: UIImageView!
    
    @IBOutlet weak var bottomView: UIImageView!
    
    @IBOutlet weak var overlayButton: UIButton!
    
    @IBOutlet weak var overlayTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    var reviewAskLabel : UILabel!
    
    
    var scene: Scene!
    var down = false
    var goodAnswersGiven = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 50, right: 0)
        
        self.tableView.register(UINib(nibName: "MultipleChoicesTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "MultipleChoicesTableViewCell")
        
        initScene()
        
        initTopImage()
        initProgressBar()
        initBottomView()
        initOverlayButton()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func didTapedButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)

    }
    
    // MARK: Init functions
    func initTopImage() {
        
        let imageName = "maskInfo"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)

        let labelInfo = UILabel()
        if !self.scene.currentPlan.isMultipleAnswers {
            imageView.frame = CGRect(x: 23, y: 29, width: 143, height: 30)
            labelInfo.text = "Quizz | 1 Réponse"
            labelInfo.frame = CGRect(x: 9, y: 6, width: 125, height: 19)
        }
        else{
            imageView.frame = CGRect(x: 23, y: 29, width: 201, height: 30)
            labelInfo.text = "Quizz | Réponses multiples"
            labelInfo.frame = CGRect(x: 9, y: 6, width: 182, height: 19)
        }
        labelInfo.font = UIFont(name: "Avenir-Heavy", size: 14)
        labelInfo.textColor = .white
        
        self.topImage.addSubview(imageView)
        imageView.addSubview(labelInfo)
    }
    
    func initProgressBar(){
        
        let jauge = UIImageView(image: UIImage(named: "jauge"))
        if !self.scene.currentPlan.isMultipleAnswers {
            jauge.frame = CGRect(x: 0, y: 0, width: 75, height: 4)
        }
        else {
            jauge.frame = CGRect(x: 0, y: 0, width: 150, height: 4)
        }
        jauge.contentMode = .scaleAspectFill
        progressBar.addSubview(jauge)
    }
    
    func initBottomView(){
        
        self.down = false
        self.overlayTopConstraint.constant = 270
        self.view.layoutIfNeeded()

        self.bottomView.subviews.forEach({ $0.removeFromSuperview() })

        let askLabel = UILabel()
        askLabel.attributedText = self.scene.currentPlan.ask
        askLabel.frame = CGRect(x: 17, y: 63, width: 342, height: 317)
        askLabel.numberOfLines = 0
        askLabel.textAlignment = .center
        self.bottomView.addSubview(askLabel)
        
        let reviewAskLabel = UILabel()
        reviewAskLabel.font = UIFont(name: "Avenir-Medium", size: 20)
        reviewAskLabel.text = "Revoir la question"
        reviewAskLabel.textColor = .white
        reviewAskLabel.frame = CGRect(x: 17, y: 10, width: 342, height: 30)
        reviewAskLabel.textAlignment = .center
        reviewAskLabel.isHidden = true
        self.reviewAskLabel = reviewAskLabel
        self.bottomView.addSubview(reviewAskLabel)

    }
    
    func initOverlayButton() {
        
        self.overlayButton.setImage(nil, for: .normal)
        let blur = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffect.Style.light))
        blur.frame = self.overlayButton.bounds
        blur.isUserInteractionEnabled = false
        overlayButton.insertSubview(blur, at: 0)
        
        let maskView = UIImageView()
        maskView.image = UIImage(named: "path12")
        maskView.frame = overlayButton.bounds
        overlayButton.mask = maskView


        let arrowView = UIImageView()
        arrowView.image = #imageLiteral(resourceName: "arrow")
        arrowView.frame = CGRect(x: 17, y: 10, width: 19, height: 38)
        arrowView.contentMode = .scaleAspectFit
        overlayButton.insertSubview(arrowView, at: 1)

    }
    
    
    // MARK: Animate Overlay
    @IBAction func downOverlay(_ sender: Any) {
        
        
        let affineTransform : CGAffineTransform
       
        
        if !self.down {
            self.overlayTopConstraint.constant = 622
            affineTransform = CGAffineTransform(scaleX: 1, y: -1)
            self.down = true
        }else{
            self.overlayTopConstraint.constant = 270
            affineTransform = CGAffineTransform(scaleX: 1, y: 1)
            down = false
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.overlayButton.subviews[1].transform = affineTransform
            self.view.layoutIfNeeded()
            if !self.down {
                self.reviewAskLabel.isHidden = !self.reviewAskLabel.isHidden
            }
        }) { (finished) in
            if self.down {
                self.reviewAskLabel.isHidden = !self.reviewAskLabel.isHidden
            }
            
        }

    }
    
    // MARK: Pop up ResumeView
    func popOverResume(_ isEnd: Bool = false){
        if let presentedViewController = self.storyboard?.instantiateViewController(withIdentifier: "EndScene") as? EndSceneViewController {
            presentedViewController.providesPresentationContextTransitionStyle = true
            presentedViewController.definesPresentationContext = true
            presentedViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
            
            presentedViewController.currentPlan = self.scene.currentPlan
            presentedViewController.isEndScene = isEnd
            presentedViewController.anchor =  isEnd == true ? .bottom : .top
            presentedViewController.delegate = self
            self.present(presentedViewController, animated: true, completion: nil)
        }
    }
}

    // MARK: TableView Delegates
extension SceneViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if scene.currentPlan.isMultipleAnswers, !scene.currentPlan.isViewedMutlipleInfo {
            return 1
        }
        return scene.currentPlan.answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if scene.currentPlan.isMultipleAnswers, !scene.currentPlan.isViewedMutlipleInfo , let cell = tableView.dequeueReusableCell(withIdentifier: "MultipleChoicesTableViewCell", for: indexPath) as? MultipleChoicesTableViewCell {
                cell.delegate = self
                return cell
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerTableViewCell", for: indexPath) as? AnswerTableViewCell {
            let answer = scene.currentPlan.answers[indexPath.row]
            cell.isUserInteractionEnabled = true
            cell.initCell(answer: answer)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if scene.currentPlan.isMultipleAnswers, !scene.currentPlan.isViewedMutlipleInfo {
            return 320
        }
        return 100
    }
}


// MARK: AnswerTableViewCell Delegate
extension SceneViewController : AnswerTableViewCellDelegate {
    func didEndPlan(_ sender: AnswerTableViewCell) {
        
        self.goodAnswersGiven += 1
        
        var nbGoodAnswers = 0
        for answer in self.scene.currentPlan.answers {
            if answer.1 == true {
                nbGoodAnswers += 1
            }
        }
        if nbGoodAnswers == goodAnswersGiven {
            self.popOverResume()
        }
    }
}

// MARK: MultipleChoicesTableViewCell Delegate
extension SceneViewController: MultipleChoicesTableViewCellDelegate {
    func didCloseInfoMultiple(_ sender: MultipleChoicesTableViewCell) {
        self.scene.currentPlan.isViewedMutlipleInfo = true
        self.tableView.reloadData()
        self.tableView.allowsSelection = true
        self.tableView.allowsMultipleSelection = true
    }
    
    
}

// MARK: EndSceneViewController Delegate
extension SceneViewController : EndSceneViewControllerDelegate {
    func popOut(state: sceneState) {
        switch state {
        case .redo:
            self.tableView.reloadData()
        case .next:
            if self.scene.indexCurrent != self.scene.plans.endIndex {
                self.scene.indexCurrent += 1
                self.scene.currentPlan = self.scene.plans[self.scene.indexCurrent]
                
            }
            self.overlayButton.subviews[1].transform = CGAffineTransform(scaleX: 1, y: 1)
            if scene.currentPlan.isMultipleAnswers, !scene.currentPlan.isViewedMutlipleInfo {
                self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
                self.tableView.allowsSelection = false;
            }
            self.tableView.reloadData()
        case .score:
            self.popOverResume(true)
        
        }
        self.goodAnswersGiven = 0
        initTopImage()
        initProgressBar()
        initBottomView()
    }
    
}

// MARK: Init the Fake Data ===> Communication Services Needed
extension SceneViewController {
    func initScene(){
        self.scene = Scene()
        
        let plan1 = Plans()
        let plan2 = Plans()
        initplan1(plan: plan1)
        initplan2(plan: plan2)
        scene.plans = [plan1,plan2]
        scene.currentPlan = scene.plans[0]
    }
    
    func initplan1(plan: Plans){
        let ask = NSMutableAttributedString(string: "Tu prépares le dîner avec ta super-copine Cata Woman, la reine des maladresses. Soudain, tu l’entends hurler !\nElle vient de se blesser gravement avec une boîte de conserve. \n\nQUE FAIS-TU ENSUITE ?", attributes: [
            .font: UIFont(name: "Avenir-Medium", size: 22.0)!,
            .foregroundColor: UIColor(white: 1.0, alpha: 1.0)
            ])
        ask.addAttribute(.font, value: UIFont(name: "Avenir-Heavy", size: 24.0)!, range: NSRange(location: 176, length: 21))
        plan.ask = ask
        plan.answers = [("j'alerte les secours",false),("je m'envais en courant",false),("je vérifie si Camille est consciente",true)]
        plan.infoMessage = .advice
        
        
    }
    
    func initplan2(plan:Plans){
        let ask = NSMutableAttributedString(string: "Camille ne respire pas.\n\nQUE FAIS-TU ENSUITE ?", attributes: [
            .font: UIFont(name: "Avenir-Medium", size: 22.0)!,
            .foregroundColor: UIColor(white: 1.0, alpha: 1.0)
            ])
        ask.addAttribute(.font, value: UIFont(name: "Avenir-Heavy", size: 24.0)!, range: NSRange(location: 25, length: 21))
        plan.ask = ask
        plan.answers = [("je donne des claques à Camille pour la réveiller",false),("je demande à Jean d'appeler les secours",true),("je demande a Jean s'il va bien",false),("je fais un massage cardiaque",true)]
        plan.isMultipleAnswers = true
        plan.infoMessage = .resume
        plan.isLastPlan = true
        
    }
}
