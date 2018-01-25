//
//  SecurityViewController.swift
//  Dex
//
//  Created by Felipe Campos on 1/25/18.
//  Copyright © 2018 Orange Inc. All rights reserved.
//

import UIKit

class SecurityViewController: UIViewController, UITextFieldDelegate, SecurityViewDelegate {
    
    // MARK: Properties
    
    @IBOutlet var dexLogo: UIImageView!
    @IBOutlet var finishingUpLabel: UILabel!
    var securityCardView: SecuritySetUpCardView!
    var cards: [Card] = []
    
    // MARK: Initialization

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hideKeyboardWhenTappedAround()
        
        securityCardView = SecuritySetUpCardView()
        
        securityCardView.delegate = self
        securityCardView.textFieldDelegate = self
        securityCardView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(securityCardView)
        
        makeView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Methods
    
    func makeView() {
        dexLogo.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Utils.largeOffset)
            make.centerX.equalToSuperview()
            make.height.equalTo(Utils.hugeOffset)
            make.width.equalTo(dexLogo.snp.height).multipliedBy(1.0 / 1.0)
        }
        
        finishingUpLabel.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualTo(dexLogo.snp.bottom).offset(Utils.largeOffset) // TODO: offset from logo
            make.centerX.equalToSuperview()
        }
        
        securityCardView.snp.makeConstraints { (make) in
            make.top.equalTo(finishingUpLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(40)
        }
        
        securityCardView.makeView()
    }
    
    // MARK: Protocols
    
    func saveButtonTapped() {
        self.performSegue(withIdentifier: "securityComplete", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! ViewController
        cards[0].user().setPassword(pass: securityCardView.password())
        vc.cards = cards
    }
}
