

//
//  PopPicView.swift
//  Wallpaper
//
//  Created by Cary on 2019/1/2.
//  Copyright © 2019 Cary. All rights reserved.
//

import UIKit
import Hue
import Toast_Swift

enum sourceType {
    case main,pc
}

typealias deleteBack = ()->Void

class PopPicView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var alertView:UIView!
    var imageView:UIImageView!
    var isOrNotAlert = false
    var imgStr = ""
    var pushType:sourceType!
    var deleteCallBack:deleteBack?
    
    convenience  init(frame: CGRect,theUrl:String,theTitle:String,theType:sourceType) {
        
        self.init(frame: frame)
        
        imgStr = theUrl
        pushType = theType
    
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
        
        let titleLabel = UILabel()
        titleLabel.text = theTitle
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.numberOfLines = 0
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            
            make.bottom.equalTo(self.snp.bottom).offset(-16)
            make.left.equalTo(self.snp.left).offset(16)
            make.right.equalTo(self.snp.right).offset(-16)
        }
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        self.addGestureRecognizer(tap)
        
        let tap1 = UISwipeGestureRecognizer(target: self, action: #selector(popBack))
        tap1.direction = .down
        self.addGestureRecognizer(tap1)
        
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(savePic))
        self.addGestureRecognizer(longTap)
        
        
        alertView = UIView(frame: CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 150))
        alertView.backgroundColor = UIColor.white
        self.addSubview(alertView)
        let saveButton = UIButton(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 50))
        alertView.addSubview(saveButton)
        saveButton.setTitle("保存", for: .normal)
        saveButton.setTitleColor(UIColor.black, for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        let collectionButton = UIButton(frame: CGRect(x: 0, y: 50, width: ScreenWidth, height: 50))
        alertView.addSubview(collectionButton)
        if pushType == .main {
            collectionButton.setTitle("收藏", for: .normal)
        } else {
            collectionButton.setTitle("取消收藏", for: .normal)
        }
        
        collectionButton.setTitleColor(UIColor.black, for: .normal)
        collectionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        collectionButton.addTarget(self, action: #selector(collcetion), for: .touchUpInside)
        
        let cancelButton = UIButton(frame: CGRect(x: 0, y: 100, width: ScreenWidth, height: 50))
        alertView.addSubview(cancelButton)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(UIColor.black, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        let line = UIView(frame: CGRect(x: 0, y: 50, width: ScreenWidth, height: 1))
        alertView.addSubview(line)
        line.backgroundColor = UIColor(hex: "#999999")
        
        let line1 = UIView(frame: CGRect(x: 0, y: 100, width: ScreenWidth, height: 1))
        alertView.addSubview(line1)
        line1.backgroundColor = UIColor(hex: "#999999")
        
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
    
    @objc func tapClick () {
    
        if isOrNotAlert == false {
            
            UIView.animate(withDuration: 0.25, animations: {
                self.alpha = 0
            }) { (finished) in
                
                self.removeFromSuperview()
                
            }
        } else {
            
            isOrNotAlert = false
            UIView.animate(withDuration: 0.25, animations: {
                self.alertView.alpha = 0
            }) { (finished) in
                
                self.alertView.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 150)
                
            }
        }
    }
    
    @objc func savePic() {
        
        self.isOrNotAlert = true
        
        UIView.animate(withDuration: 0.5) {
            
            self.alertView.frame = CGRect(x: 0, y: ScreenHeight-150, width: ScreenWidth, height: 150)
            self.alertView.alpha = 1
        }
        
    }
    
    @objc func cancel () {
        
        self.isOrNotAlert = false
        UIView.animate(withDuration: 0.25, animations: {
            self.alertView.alpha = 0
        }) { (finished) in
            
           self.alertView.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 150)
            
        }
    }
    
    @objc func collcetion () {
        
        self.isOrNotAlert = false
        
        var tipTitle = ""

        let path = NSHomeDirectory() as NSString
        let docPath = (path as String) + "/Documents/" + "data.plist"
        
        var arr:NSMutableArray?
        
        arr = NSMutableArray.init(contentsOfFile: docPath)

        if arr == nil {
            
            arr = NSMutableArray.init()
        }
        
        if pushType == .main {
            
            tipTitle = "已收藏"
            arr!.add(imgStr)
            
        } else {
            
            tipTitle = "已取消收藏"
            arr?.remove(imgStr)
        }
        
        arr!.write(toFile: docPath, atomically: true)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alertView.alpha = 0
        }) { (finished) in
            
            self.alertView.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 150)
            let textLabel = UILabel(frame: CGRect(x: ScreenWidth/2-50, y: ScreenHeight/2-20, width: 100, height: 40))
            textLabel.text = tipTitle
            textLabel.textAlignment = .center
            textLabel.font = UIFont.systemFont(ofSize: 15)
            textLabel.textColor = UIColor.black
            textLabel.backgroundColor = UIColor(hex: "#eeeeee")
            
            self.showToast(textLabel, duration: 1, position: .center) { (bool) in
                
                if self.pushType == .pc {
                    
                    self.deleteCallBack!()
                    UIView.animate(withDuration: 0.25, animations: {
                        self.alpha = 0
                    }) { (finished) in
                        
                        self.removeFromSuperview()
                        
                    }
                }
                
            }
            
        }
        
    }
    
    @objc func save () {
        
        self.isOrNotAlert = false
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alertView.alpha = 0
        }) { (finished) in
            
            self.alertView.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 150)
            UIImageWriteToSavedPhotosAlbum(self.imageView.image!, self, #selector(self.didSavePic(image:error:contextInfo:)), nil)
            
        }
    }
    
    @objc func didSavePic (image:UIImage,error:Error,contextInfo:Any) {
    
    let textLabel = UILabel(frame: CGRect(x: ScreenWidth/2-50, y: ScreenHeight/2-20, width: 100, height: 40))
    textLabel.text = "图片已保存"
    textLabel.textAlignment = .center
    textLabel.font = UIFont.systemFont(ofSize: 15)
    textLabel.textColor = UIColor.black
    textLabel.backgroundColor = UIColor(hex: "#eeeeee")
    
    self.showToast(textLabel, duration: 1, position: .center) { (bool) in
        
    }
    }
    
}
