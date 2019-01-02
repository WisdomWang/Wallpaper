

//
//  PopPicView.swift
//  Wallpaper
//
//  Created by Cary on 2019/1/2.
//  Copyright © 2019 Cary. All rights reserved.
//

import UIKit
import Hue

class PopPicView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var alertView:UIView!
    
    convenience  init(frame: CGRect,theUrl:String) {
        
        self.init(frame: frame)
        var imageView:UIImageView!
    
        let bg = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        bg.backgroundColor = UIColor.black
        self.addSubview(bg)
        
        imageView = UIImageView()
        let url = URL(string: theUrl)
        imageView.kf.setImage(with: url)
        bg.addSubview(imageView)
        imageView.isUserInteractionEnabled = true
        imageView.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(bg.snp.centerX)
            make.centerY.equalTo(bg.snp.centerY)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(popBack))
        self.addGestureRecognizer(tap)
        
        let tap1 = UISwipeGestureRecognizer(target: self, action: #selector(popBack))
        tap1.direction = .down
        self.addGestureRecognizer(tap1)
        
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(savePic))
        self.addGestureRecognizer(longTap)
        
        
        alertView = UIView(frame: CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 100))
        alertView.backgroundColor = UIColor.white
        self.addSubview(alertView)
        let saveButton = UIButton(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 50))
        alertView.addSubview(saveButton)
        saveButton.setTitle("保存", for: .normal)
        saveButton.setTitleColor(UIColor.black, for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        let cancelButton = UIButton(frame: CGRect(x: 0, y: 50, width: ScreenWidth, height: 50))
        alertView.addSubview(cancelButton)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(UIColor.black, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        let line = UIView(frame: CGRect(x: 0, y: 50, width: ScreenWidth, height: 1))
        alertView.addSubview(line)
        line.backgroundColor = UIColor(hex: "#999999")
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func popBack() {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
        }) { (finished) in
            
            self.removeFromSuperview()
            
        }
    }
    
    @objc func savePic() {
        
        UIView.animate(withDuration: 0.5) {
            
            self.alertView.frame = CGRect(x: 0, y: ScreenHeight-100, width: ScreenWidth, height: 100)
            self.alertView.alpha = 1
        }
        
    }
    @objc func cancel () {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alertView.alpha = 0
        }) { (finished) in
            
           self.alertView.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 100)
            
        }
    }
    @objc func save () {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alertView.alpha = 0
        }) { (finished) in
            
            self.alertView.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 100)
            
        }
    }
}
