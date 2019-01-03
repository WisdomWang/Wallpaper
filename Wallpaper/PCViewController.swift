//
//  PCViewController.swift
//  Wallpaper
//
//  Created by Cary on 2018/12/21.
//  Copyright © 2018 Cary. All rights reserved.
//

import UIKit

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
