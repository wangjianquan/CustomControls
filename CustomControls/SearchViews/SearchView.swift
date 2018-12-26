//
//  SearchView.swift
//  Classified_Information
//
//  Created by wjq on 2017/11/8.
//  Copyright © 2017年 wjq. All rights reserved.
//

import UIKit


class SearchView: UIView {
    
    let space: CGFloat = 5
    
    // MARK: - placeHolder
    @IBInspectable
    var placeHolder: String? = "请输入搜索关键字"{
        didSet{
            searchField.placeholder = placeHolder
        }
    }
    
    // MARK: - 背景色
    @IBInspectable
    var bgViewColor: UIColor? = UIColor.white{
        didSet{
            self.backgroundColor = bgViewColor
        }
    }
    
    // MARK: - 短竖线颜色
    @IBInspectable
    var lineColor: UIColor? = UIColor.darkGray{
        didSet{
            self.lineView.backgroundColor = lineColor
        }
    }
    
    // MARK: - textField背景颜色
    @IBInspectable
    var fieldBgColor: UIColor? = UIColor.white{
        didSet{
            self.searchField.backgroundColor = fieldBgColor
        }
    }
    fileprivate lazy var lineView : UIView = {
        let line = UIView()
        line.backgroundColor = lineColor
        return line
    }()
    
    fileprivate lazy var searchImg : UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "img_search")
        return icon
    }()
    
    lazy var searchField: UITextField = {
        let field = UITextField()
        field.placeholder = placeHolder
        field.backgroundColor = fieldBgColor
        field.clearButtonMode = UITextField.ViewMode.never
        field.adjustsFontSizeToFitWidth = true
        field.font = UIFont.systemFont(ofSize: 14)
        field.minimumFontSize = 10  //最小可缩小的字号
        return field
    }()
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    
    fileprivate func setupUI(){
        self.backgroundColor = bgViewColor
        
        
        
//        searchImg.frame = CGRect(x: 8, y: 10, width: 23, height: 23)
//        lineView.frame = CGRect(x: searchImg.frame.size.width + searchImg.frame.origin.x + space , y: 10, width: 1, height: searchViewHeight - 20)
//        searchField.frame = CGRect(x: lineView.frame.origin.x + space, y: 0 , width: (self.frame.size.width - lineView.frame.origin.x + space), height: searchViewHeight)
        
        searchImg.translatesAutoresizingMaskIntoConstraints     = false
        lineView.translatesAutoresizingMaskIntoConstraints      = false
        searchField.translatesAutoresizingMaskIntoConstraints   = false
        
        addSubview(searchImg)
        addSubview(lineView)
        addSubview(searchField)
      
        
        let imageleft = NSLayoutConstraint(item: searchImg, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 8)
        let imageWidht = NSLayoutConstraint.init(item: searchImg, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 15)
        let imageHeight = NSLayoutConstraint.init(item: searchImg, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 15)
        let imageCenter = NSLayoutConstraint(item: searchImg, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraints([imageleft,imageWidht,imageHeight,imageCenter])


        let lineTop = NSLayoutConstraint(item: lineView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 5)
        let lineleft = NSLayoutConstraint(item: lineView, attribute: .left, relatedBy: .equal, toItem: searchImg, attribute: .right, multiplier: 1, constant: 8)
        let lineBottom = NSLayoutConstraint(item: lineView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -5)
        let lineWidth = NSLayoutConstraint(item: lineView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 1)
        self.addConstraints([lineleft,lineTop,lineBottom,lineWidth])

       
        
        let fieldTop = NSLayoutConstraint(item: searchField, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 5)
        let fieldLeft = NSLayoutConstraint(item: searchField, attribute: .left, relatedBy: .equal, toItem: lineView, attribute: .right, multiplier: 1, constant: 8)
        let fieldBottom = NSLayoutConstraint(item: searchField, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -5)
        let fieldRight = NSLayoutConstraint(item: searchField, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -12)

        
        self.addConstraints([fieldTop,fieldLeft,fieldRight,fieldBottom])
    }
    
}



