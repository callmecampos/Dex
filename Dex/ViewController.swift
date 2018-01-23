//
//  ViewController.swift
//  Dex
//
//  Created by Felipe Campos on 8/8/17.
//  Copyright © 2017 Orange Inc. All rights reserved.
//

import UIKit
import SnapKit
import Contacts
import CoreLocation

class ViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: Properties
    
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var swipeLabel: UILabel!
    @IBOutlet var newContactsLabel: UILabel!
    var popUpSendView: UIView! // FIXME: make this functional or at least look good (see below)
    var editView: UIView! // FIXME: maybe make into custom view class? idk
    var cardView: CardView!
    var cards: [Card] = []
    var cardIndex = 0
    // TODO: scroll vs send switch!!
    // TODO: have some sort of mini page controller for cards
    // TODO: implement swipe upward to constrast sideways mechanism (maybe lock card?) idk
    
    // MARK: Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        popUpSendView.isHidden = true
        
        cardView = CardView(card: cards[cardIndex])
        self.view.addSubview(cardView)
        
        leftButton.isHidden = true
        if cards.count == 1 {
            rightButton.isHidden = true
        }
        
        // TODO: figure out data flow logic for users on whiteboard or notebook --> core data or NSUserDefaults?
        // TODO: display cards based on priority, binary search tree style?? (main in middle, cascade down on sides)
        
        // if no cards, display 'Add your first card here!'
        
        makeView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    func leftButtonTapped(_ button: UIButton) {
        rightButton.isHidden = false
        cardIndex -= 1
        if cardIndex == 0 {
            leftButton.isHidden = true
        }
        
        cardView.setCard(card: cards[cardIndex])
    }
    
    func rightButtonTapped(_ button: UIButton) {
        leftButton.isHidden = false
        cardIndex += 1
        if cardIndex == cards.count - 1 {
            rightButton.isHidden = true
        }
        
        cardView.setCard(card: cards[cardIndex])
    }
    
    // MARK: Methods
    
    private func loadSendView() { // FIXME:
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 200)
        popUpSendView = UIView(frame: frame)
        
        view.addSubview(popUpSendView)
        
        popUpSendView.isHidden = false
        
        // TODO: should probably make this a custom class of some sort, with delegates allowing this VC to dictate logic
        
        let buttonFrame = CGRect(x: 40, y: 100, width: 50, height: 50)
        let okayButton = UIButton(frame: buttonFrame)
        
        // here we are adding the button its superView
        popUpSendView.addSubview(okayButton)
        
        okayButton.addTarget(self, action: #selector(sendViewCompletion(_:)), for: .touchUpInside)
    }
    
    func sendViewCompletion(_ sender: UIButton) {
        // do whatever you want
        // make view disappear again or remove from its superview
    }
    
    private func loadEditingView(card: Card) { // FIXME:
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 200)
        editView = UIView(frame: frame)
        
        view.addSubview(editView)
        
        editView.isHidden = false
        
        // TODO: should probably make this a custom class of some sort, with delegates allowing this VC to dictate logic
        
        let buttonFrame = CGRect(x: 40, y: 100, width: 50, height: 50)
        let okayButton = UIButton(frame: buttonFrame)
        
        // here we are adding the button its superView
        editView.addSubview(okayButton)
        
        okayButton.addTarget(self, action: #selector(editingViewCompletion(_:)), for: .touchUpInside)
    }
    
    func editingViewCompletion(_ sender: UIButton) {
        // do whatever you want
    }
    
    func makeView() {
        swipeLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(swipeLabel.font.lineHeight)
        }
        
        cardView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(swipeLabel.snp.bottom).offset(Utils.largeOffset)
            make.left.equalToSuperview().offset(Utils.largeOffset)
            make.right.equalToSuperview().inset(Utils.largeOffset)
            make.bottom.equalTo(newContactsLabel.snp.top).inset(Utils.largeOffset)
        }
        
        cardView.makeView()
        
        leftButton.addTarget(self, action: #selector(self.leftButtonTapped(_:)), for: .touchUpInside)
        leftButton.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(cardView.snp.centerY)
            make.left.equalToSuperview().offset(5)
            make.right.lessThanOrEqualTo(cardView.snp.left).offset(5)
        }
        
        rightButton.addTarget(self, action: #selector(self.rightButtonTapped(_:)), for: .touchUpInside)
        rightButton.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(cardView.snp.centerY)
            make.right.equalToSuperview().offset(5)
            make.left.greaterThanOrEqualTo(cardView.snp.right).offset(5)
        }
        
        newContactsLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(cardView.snp.bottom).offset(Utils.largeOffset)
            make.height.equalTo(newContactsLabel.font.lineHeight)
        }
    }
}

