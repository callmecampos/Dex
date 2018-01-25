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

class ViewController: UIViewController, UIScrollViewDelegate, MultipeerManagerDelegate, CardViewDelegate {
    
    // MARK: Properties
    
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var swipeLabel: UILabel!
    @IBOutlet var embeddedTableView: UIView!
    @IBOutlet var exchangeButton: UIButton!
    @IBOutlet var dexLogo: UIImageView!
    
    var cardView: CardView!
    var cards: [Card] = []
    var cardIndex = 0
    // TODO: scroll vs send switch!!
    // TODO: have some sort of mini page controller for cards
    // TODO: implement swipe upward to constrast sideways mechanism (maybe lock card?) idk
    
    let multipeerService = MultipeerManager()
    
    // MARK: Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if cards.count == 0 {
            // FIXME: get cards from user defaults
        }
        
        multipeerService.delegate = self
        
        embeddedTableView.isHidden = true
        exchangeButton.isHidden = true
        embeddedTableView.alpha = 0
        
        cardView = CardView(card: cards[cardIndex])
        self.view.addSubview(cardView)
        
        cardView.delegate = self
        
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
    
    
    @IBAction func exchangeAction(_ sender: Any) {
        print("Hiding embedded views.")
        UIView.animate(withDuration: 5.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            self.embeddedTableView.alpha = 0.0
        }, completion: nil)
        embeddedTableView.isHidden = true
        exchangeButton.isHidden = true
    }
    
    // MARK: Methods
    
    func sendViewCompletion(_ sender: UIButton) {
        // do whatever you want
        // make view disappear again or remove from its superview
    }
    
    func editingViewCompletion(_ sender: UIButton) {
        // do whatever you want
    }
    
    func makeView() {
        dexLogo.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Utils.hugeOffset * 2)
            make.centerX.equalToSuperview()
            make.height.equalTo(Utils.hugeOffset)
            make.width.equalTo(dexLogo.snp.height).multipliedBy(2.1 / 1.0)
        }
        
        welcomeLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(dexLogo.snp.bottom).offset(Utils.hugeOffset * 2)
            make.centerX.equalToSuperview()
            make.height.equalTo(welcomeLabel.font.lineHeight)
        }
        
        cardView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(Utils.largeOffset)
            make.left.equalToSuperview().offset(Utils.largeOffset)
            make.right.equalToSuperview().inset(Utils.largeOffset)
            make.height.equalTo(cardView.snp.width).multipliedBy(1.0 / 2.0)
        } // TODO: make fixed height??
        
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
        
        swipeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cardView.snp.bottom).offset(Utils.largeOffset)
            make.centerX.equalToSuperview()
            make.height.equalTo(swipeLabel.font.lineHeight)
        }
        
        embeddedTableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Utils.mediumOffset)
            make.right.equalToSuperview().offset(Utils.mediumOffset)
            make.height.equalTo(self.view.snp.height).inset(150)
            make.top.equalTo(dexLogo.snp.bottom).offset(Utils.largeOffset)
        }
        
        exchangeButton.snp.makeConstraints { (make) in
            make.top.equalTo(embeddedTableView.snp.bottom).offset(Utils.smallOffset)
            make.centerX.equalToSuperview()
            // TODO: aspect ratio??
        }
    }
    
    // MARK: Protocols
    
    func connectedDevicesChanged(manager: MultipeerManager, connectedDevices: [String]) {
        // FIXME: implement
    }
    
    func cardReceived(manager: MultipeerManager, card: Card) {
        // FIXME: implement
    }
    
    func sendCard(card: Card) {
        // FIXME: implement
        print("Showing embedded views.")
        self.view.bringSubview(toFront: embeddedTableView)
        self.view.bringSubview(toFront: exchangeButton)
        embeddedTableView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            self.embeddedTableView.alpha = 1.0
        }, completion: nil)
        exchangeButton.isHidden = false
    }
    
    func showStatistics(card: Card) {
        // FIXME: implement
    }
}

