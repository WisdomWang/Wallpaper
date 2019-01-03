//
//  ViewController.swift
//  Wallpaper
//
//  Created by Cary on 2018/12/18.
//  Copyright © 2018 Cary. All rights reserved.
//

import UIKit
import ESPullToRefresh
import Kingfisher
import Alamofire
import ESPullToRefresh

let ScreenWidth  = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height
let statusBarHeight = UIApplication.shared.statusBarFrame.size.height

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var collectionView :UICollectionView?
    let identifier = "MyCell"
    var mainDataArr = [Any]()
    var page = 1
    var category:String!
    var tempTag:Int!
    
    let  textArr = ["所有", "大胸", "翘臀", "黑丝", "美腿", "清新", "其他"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.navigationItem.title = "Sexy"
        self.view.backgroundColor = UIColor.white
        category = "All"
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: statusBarHeight, width: ScreenWidth, height: 40))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        
        for i in 0..<textArr.count {
            let theX = i%7
            let button = UIButton(frame: CGRect(x: theX*60, y: 0, width: 60, height: 40))
            button.setTitle(textArr[i], for: .normal)
            button.backgroundColor = UIColor.white
            button.setTitleColor(UIColor.black, for: .normal)
            scrollView.addSubview(button)
            button.tag = 1000+i
            button.addTarget(self, action: #selector(changeData(button:)), for: .touchUpInside)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.isSelected = false
            
            if i == 0 {
              button.setTitleColor(UIColor.red, for: .normal)
              button.isSelected = true
              tempTag = button.tag
            }
            
        }
        scrollView.contentSize = CGSize(width: 420, height: 40)
        self.view.addSubview(scrollView)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:CGFloat((ScreenWidth-10)/3), height:CGFloat((ScreenWidth-10)/3))
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .vertical
       // layout.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        
        collectionView = UICollectionView.init(frame: CGRect(x: 0, y: statusBarHeight+40, width: ScreenWidth, height: ScreenHeight), collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        self.view.addSubview(collectionView!)
        collectionView?.register(MainCell.self, forCellWithReuseIdentifier: identifier)
        
        collectionView?.es.addPullToRefresh {
            
            self.page = 1
            self.mainDataArr.removeAll()
            self.loadData()
            
        }
        
        collectionView?.es.addInfiniteScrolling {
            
            self.page = self.page + 1
            self.loadData()
        }
        
        collectionView?.es.startPullToRefresh()
    
    }
    override func viewWillAppear(_ animated: Bool) {

        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  mainDataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:MainCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MainCell
        let user:mainModel = mainDataArr[indexPath.row] as! mainModel
        let url = URL(string: user.imageUrlSmall!)
        cell.image.kf.setImage(with: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let user:mainModel = mainDataArr[indexPath.row] as! mainModel
        let popPicView = PopPicView(frame: self.view.frame, theUrl: user.imageUrlBig!,theTitle:user.title!)
        let window = UIApplication.shared.windows.first
        window?.insertSubview(popPicView, aboveSubview: self.view)
    }
    
    @objc func changeData (button:UIButton) {
        
        if button.tag == 1000 {
            
            category = "All"
        }
        else if button.tag == 1001 {
            category = "DaXiong"
        }
        else if button.tag == 1002 {
            category = "QiaoTun"
        }
        else if button.tag == 1003 {
            category = "HeiSi"
        }
        else if button.tag == 1004 {
            category = "MeiTui"
        }
        else if button.tag == 1005 {
            category = "QingXin"
        }
        else if button.tag == 1006 {
            category = "ZaHui"
        }
        
        let tempButton:UIButton = self.view.viewWithTag(tempTag) as! UIButton
        tempButton.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        tempTag = button.tag
        
        collectionView?.es.startPullToRefresh()
    }
    
    func loadData () {
        
        let urlStr:String =  "https://meizi.leanapp.cn/category/"+category+"/page/\(page)"
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            print(response.result.value as Any)
            
            let dic:Dictionary<String,Any> = response.result.value as! Dictionary
            var arr:Array<Any>? = dic["results"] as? Array<Any>
            if !(arr != nil) {
                
                self.collectionView?.es.noticeNoMoreData()
                return
                
            }
            self.collectionView?.es.stopPullToRefresh()
            self.collectionView?.es.stopLoadingMore()
            for i in 0..<arr!.count {
                
                let dic2:Dictionary<String,Any> = arr?[i] as! Dictionary<String, Any>
                let user = mainModel(JSON:dic2)
                self.mainDataArr.append(user as Any)
                
            }
            
            self.collectionView?.reloadData()
            
        }
        
    }

}

