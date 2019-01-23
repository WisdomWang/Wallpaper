//
//  CollectionViewController.swift
//  Wallpaper
//
//  Created by Cary on 2019/1/11.
//  Copyright © 2019 Cary. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    
    var collectionView :UICollectionView?
    let identifier = "CollectionCell"
    var mainDataArr = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "我的收藏"
        let path = NSHomeDirectory() as NSString
        let docPath = (path as String) + "/Documents/" + "data.plist"
        let arr = NSArray.init(contentsOfFile: docPath)
       
        if !(arr == nil) {
            
             mainDataArr =  arr as! [Any]

        }
       
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:CGFloat((ScreenWidth-10)/3), height:CGFloat((ScreenWidth-10)/3))
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .vertical
        // layout.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        
        collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        self.view.addSubview(collectionView!)
        collectionView?.register(MainCell.self, forCellWithReuseIdentifier: identifier)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  mainDataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:MainCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MainCell
       // cell.image.image = (mainDataArr[indexPath.row] as! UIImage)
        let url = URL(string: mainDataArr[indexPath.row] as! String)
        cell.image.kf.setImage(with: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let popPicView = PopPicView(frame: self.view.frame, theUrl: mainDataArr[indexPath.row] as! String, theTitle: "", theType: .pc)
        popPicView.pushType = .pc
        popPicView.deleteCallBack = {

            self.mainDataArr.remove(at: indexPath.row);
            collectionView.reloadData()
        }
        let window = UIApplication.shared.windows.first
        window?.insertSubview(popPicView, aboveSubview: self.view)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
