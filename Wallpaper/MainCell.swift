//
//  MainCell.swift
//  Wallpaper
//
//  Created by Cary on 2018/12/28.
//  Copyright © 2018 Cary. All rights reserved.
//

import UIKit
import SnapKit

class MainCell: UICollectionViewCell {
    var image:UIImageView!
    var label:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        image = UIImageView()
        self.contentView.addSubview(image)
        label = UILabel()
        image.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.bottom.equalTo(self.contentView.snp.bottom)
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
