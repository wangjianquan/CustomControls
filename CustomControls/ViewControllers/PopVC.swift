//
//  PopVC.swift
//  Classified_Information
//
//  Created by ulinix on 2017/11/9.
//  Copyright © 2017年 wjq. All rights reserved.
//

import UIKit
import SnapKit


class PopVC: UIViewController , UITableViewDelegate, UITableViewDataSource {
  
    lazy var popTableView: UITableView = {
     let tableView = UITableView(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor.groupTableViewBackground
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        view.addSubview(tableView)
        tableView.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        return tableView
    }()
    

    
    var getDataBlock:(( _ model: Share) -> ())?
   
    var dataSource = [Share]()

    override func viewDidLoad() {
        super.viewDidLoad()
       
         self.popTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.popTableView.reloadData()
    }
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let model = dataSource[indexPath.row]
        cell.textLabel?.text = model.title
        cell.textLabel?.textAlignment = .center
       
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = dataSource[indexPath.row]
        if let getDataBlock = getDataBlock {
            getDataBlock(model)
        }
    }

}



