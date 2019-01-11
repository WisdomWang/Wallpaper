//
//  PCViewController.swift
//  Wallpaper
//
//  Created by Cary on 2018/12/21.
//  Copyright © 2018 Cary. All rights reserved.
//

import UIKit
import Kingfisher
import Toast_Swift

class PCViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    var mainTableView:UITableView!
    var titleArr = ["收藏","清除缓存"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的"

        // Do any additional setup after loading the view.
        
        mainTableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: .plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = UIColor(hex: "#f8f8f8")
        let view = UIView()
        mainTableView.tableFooterView  = view
        self.view.addSubview(mainTableView)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let identifier = "PcCell"
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.textLabel!.text = titleArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let vc = CollectionViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        else if indexPath.row == 1 {
            
           let cache = KingfisherManager.shared.cache
            var text:String!
            cache.calculateDiskCacheSize { (size) in
                print(size)
                text = "您确定清理缓存\(size/1024/1024)M么"
                let alert = UIAlertController(title: "提示", message: text, preferredStyle: .alert)
                let actionCancel = UIAlertAction(title: "取消", style: .cancel) { (alert) in
                    
                }
                let actionNext = UIAlertAction(title: "确定", style: .default) { (alert) in
                    cache.clearDiskCache()
                    
                    let textLabel = UILabel(frame: CGRect(x: ScreenWidth/2-50, y: ScreenHeight/2-20, width: 100, height: 40))
                    textLabel.text = "已清理"
                    textLabel.textAlignment = .center
                    textLabel.font = UIFont.systemFont(ofSize: 15)
                    textLabel.textColor = UIColor.black
                    textLabel.backgroundColor = UIColor(hex: "#eeeeee")
                    
                    self.view.showToast(textLabel, duration: 1, position: .center) { (bool) in
                        
                    }
                    
                }
                alert.addAction(actionCancel)
                alert.addAction(actionNext)
                self.present(alert, animated: true) {
                    
                }
            }
    
        }
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
