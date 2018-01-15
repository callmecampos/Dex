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
        
        cardView = CardView(card: cards[cardIndex])
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
    
    func makeView() {
        swipeLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.bottom.equalTo(cardView.snp.top).offset(5)
        }
        
        cardView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualTo(leftButton.snp.right).offset(5)
            make.right.lessThanOrEqualTo(rightButton.snp.left).offset(5)
        }
        
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
            make.top.equalTo(cardView.snp.bottom).offset(10)
        }
    }
    
    /* static func initTestCards() -> [Card] {
        let latitude: CLLocationDegrees = 37.2
        let longitude: CLLocationDegrees = 22.9
        
        let location: CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        let interest1 = Interest(type: .software)
        let interest2 = Interest(type: .entrepreneurship)
        
        let interests = [interest1, interest2]
        
        let u: User = User(name: "Chris", inf: 0, initPos: location, connections: [], interests: interests)
        
        let phone: Phone = Phone(number: "(804) 305-0733", kind: .mobile)
        
        let img = UIImage(contentsOfFile: "Dex60pt")
        
        let businessCard = Card(user: u, location: "Richmond, VA", occupation: "Photographer", email: "crhvpi@gmail.com", phones: [phone], web: "www.ChrisRossHarris.com", avi: img!, priority: 1)
        let personalCard = Card(user: u, location: "Virginia Beach", occupation: "Surfer", email: "chris@me.com", phones: [phone], web: "me.com", avi: img!)
        
        return [businessCard, personalCard]
    } */
}

