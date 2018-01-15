//
//  NotificationCardView.swift
//  Dex
//
//  Created by Felipe Campos on 12/28/17.
//  Copyright © 2017 Orange Inc. All rights reserved.
//

// TODO: have ad view pop up every once in a while
// TODO: work on rectangular cube vertical rotation animation for this when changing notification
// TODO: OR have options for transitions like sliding or whatever

import UIKit
import Shiny

/** A notification card view class. */
@IBDesignable
class NotificationCardView: UIView {
    
    // MARK: Properties
    
    private var _title: UILabel = UILabel()
    private var _note: UILabel = UILabel()
    private var _time: UILabel?
    private var _imageView: UIImageView?
    
    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    
    // MARK: Initialization
    
    convenience init(title: String, note: String, time: String) {
        self.init(title: title, note: note, frame: CGRect.zero)
        _time = UILabel()
        _time!.text = time
    }
    
    convenience init(title: String, note: String, time: String, img: UIImage) {
        self.init(title: title, note: note, img: img, frame: CGRect.zero)
        _time = UILabel()
        _time!.text = time
    }
    
    convenience init(title: String, note: String) {
        self.init(title: title, note: note, frame: CGRect.zero)
    }
    
    init(title: String, note: String, frame: CGRect) {
        super.init(frame: frame)
        makeView(title: title, note: note, frame: frame)
        makeShiny()
    }
    
    init(title: String, note: String, img: UIImage, frame: CGRect) {
        super.init(frame: frame)
        makeView(title: title, note: note, img: img, frame: frame)
        makeShiny()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
    // MARK: Methods
    
    func makeView(title: String, note: String, img: UIImage, frame: CGRect) {
        makeView(title: title, note: note, frame: frame)
        
        _imageView = UIImageView(image: img)
        _imageView!.layer.cornerRadius = _imageView!.frame.size.width / 2
        _imageView!.layer.masksToBounds = true
        self.addSubview(_imageView!)
        
        _imageView!.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_title.snp.bottom).offset(5)
            make.right.equalTo(self).offset(5)
            make.left.equalTo(self).offset(-5)
            make.bottom.equalTo(self).offset(-5)
        }
    }
    
    func makeView(title: String, note: String, frame: CGRect) {
        _title.text = title
        self.addSubview(_title)
        
        _title.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(5)
            make.left.equalTo(self).offset(5)
        }
        
        _note.text = note
        self.addSubview(_note)
        
        _note.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_title.snp.bottom).offset(5)
            make.right.equalTo(self.snp.left).offset(-5)
            make.left.equalTo(self).offset(5 + _imageView!.frame.size.width + 5)
            make.bottom.equalTo(self).offset(-5)
        }
    }
    
    func makeShiny() {
         let shinyView = ShinyView(frame: CGRect(x: 0, y: 0, width: 320, height: 200))
         shinyView.colors = [UIColor.red, UIColor.green, UIColor.blue, UIColor.gray]
         shinyView.locations = [0, 0.1, 0.2, 0.3, 1] // FIXME: test locations
         shinyView.startUpdates() // necessary
         self.addSubview(shinyView)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
