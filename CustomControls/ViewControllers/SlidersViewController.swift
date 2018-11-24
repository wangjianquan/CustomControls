//
//  SlidersViewController.swift
//  CustomControls
//
//  Created by landixing on 2018/9/12.
//  Copyright © 2018年 WJQ. All rights reserved.
//

import UIKit

class UYLNode<T>  {
    var data: T!
    var next: UYLNode?
    init(data: T) {
        self.data = data
    }
    
    
}

class SlidersViewController: UIViewController {

    var nameList = UYLNode<String>(data: "Tom")
    
   
    @IBOutlet weak var alertResult: UILabel!
    
    
    @IBAction func action(_ sender: Any) {
        self.navigationController?.pushViewController(DragViewController(), animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        MobClick.beginLogPageView("\(type(of: self))")
        addSlider()
        
        let names = ["Dick","Harry"]
        var head = nameList
        for name in names {
            let node = UYLNode<String>(data: name)
            head.next = node
            head = node
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        MobClick.endLogPageView("\(type(of: self))")
        let emailRule = TextValidationRule.regularExpression(emailRegex)
        let email1 = emailRule.isValid("alice@example.com")
        let email2 = emailRule.isValid("bob@gmail")
        print(email1)
        print(email2)
        
        let integerRule = TextValidationRule.predicate({ Int($0) != nil })
        
        print("\(integerRule.isValid("-789"))")
        print("\(integerRule.isValid("123a"))")
    }
    
    func addSlider()  {
        let screenWidth = UIScreen.main.bounds.size.width
        let sliderWidth: CGFloat = 200
        let start_X = (screenWidth - sliderWidth)/2
        
        //滑块1：使用默认样式、默认刻度（每10%一个刻度）
        let firstSlider = CustomSlider(frame:CGRect(x:start_X,y:0,width:sliderWidth,height:40))
        view.addSubview(firstSlider)
        
        //滑块2：修改默认样式
        let secondSlider = CustomSlider(frame:CGRect(x:start_X,y:50,width:sliderWidth,height:40))
        secondSlider.markColor = UIColor(white: 1, alpha: 0.5) //刻度颜色
        secondSlider.markPositions = [15,30,75] //刻度位置
        secondSlider.markWidth = 3.0 //刻度宽度
        secondSlider.leftBarColor = UIColor.orange //左轨道颜色
        secondSlider.rightBarColor = UIColor(red: 255/255.0, green: 222/255.0,
                                             blue: 0/255.0, alpha: 1.0) //右轨道颜色
        secondSlider.barHeight = 16 //轨道高度
        view.addSubview(secondSlider)
        
        //滑块3：除了修改默认样式，还改变控制器颜色
        let thirdSlider = CustomSlider(frame:CGRect(x:start_X,y:100,width:sliderWidth,height:40))
        thirdSlider.markColor = UIColor(white: 0, alpha: 0.1)
        thirdSlider.leftBarColor = UIColor(red: 108/255.0, green: 200/255.0, blue: 0/255.0,
                                           alpha: 1.0)
        thirdSlider.rightBarColor = UIColor(red: 138/255.0, green: 255/255.0, blue: 0/255.0,
                                            alpha: 1.0)
        thirdSlider.thumbTintColor = UIColor.orange  //改变控制器颜色
        view.addSubview(thirdSlider)
        
        //滑块4：除了修改默认样式，还改变控制器图片
        let fourthSlider = CustomSlider(frame:CGRect(x:start_X,y:150,width:sliderWidth,height:40))
        fourthSlider.markColor = UIColor(white: 0, alpha: 0.1)
        fourthSlider.leftBarColor = UIColor(red: 108/255.0, green: 200/255.0, blue: 0/255.0,
                                            alpha: 1.0)
        fourthSlider.rightBarColor = UIColor(red: 138/255.0, green: 255/255.0,
                                             blue: 0/255.0, alpha: 1.0)
        fourthSlider.setThumbImage(UIImage(named: "img_search"),
                                   for: .normal) //改变控制器图片
        fourthSlider.barHeight = 4
        view.addSubview(fourthSlider)
    }

   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    @IBOutlet weak var noRestriction: UITextField!
    @IBOutlet weak var nonEmptyField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    let emailRegex = try! NSRegularExpression(pattern: ".+@.+\\..+")
    @IBOutlet weak var label: UILabel!
    
    @IBAction func anythingAction(_ sender: Any) {
        let alert = UIAlertController(title: "任意文本", message: "任意内容,包括空字符串", cancelButtonTitle: "cancel", okButtonTitle: "OK", validate: TextValidationRule.noRestriction, textFieldConfiguration: {  (textField) in
            self.noRestriction.isEqual(textField)
             textField.placeholder = "请输入任意文本"
            self.textFieldStyle(textField: textField)
        }) { [weak self] (textInputResult) in
            switch textInputResult {
            case .cancel:
                break
            case .ok(let contentString):
                print("\(contentString)")
                self?.noRestriction.text  = contentString
                self?.label.text = contentString
            }
        }
        self.present(alert, animated: true) {
            self.becomeFirstResponder()
        }
    }
    
    @IBAction func stringlength(_ sender: Any) {
        let alert = UIAlertController(title: "非空文本", message: "请输入", cancelButtonTitle: "cancel", okButtonTitle: "OK", validate: TextValidationRule.nonEmpty, textFieldConfiguration: { (textField) in
            self.nonEmptyField.isEqual(textField)
            textField.placeholder = "请输入非空文本"

            self.textFieldStyle(textField: textField)
        }) { (textInputResult) in
            switch textInputResult {
            case .cancel:
                break
            case .ok(let contentString):
                print("\(contentString)")
                self.nonEmptyField.text  = contentString
            }
        }
        self.present(alert, animated: true) {
            self.becomeFirstResponder()
        }
    }
    
    @IBAction func emailAction(_ sender: Any) {
        let alert = UIAlertController(title: "你的邮箱", message: "请输入你的邮箱", cancelButtonTitle: "cancel", okButtonTitle: "ok", validate: TextValidationRule.regularExpression(emailRegex), textFieldConfiguration: { (textField) in
            self.emailField.isEqual(textField)
            textField.placeholder = "请输入邮箱"
            self.textFieldStyle(textField: textField)
        }) { [weak self] (textInputResult) in
            switch textInputResult {
            case .cancel:
                break
            case .ok(let contentString):
                print("\(contentString)")
                self?.emailField.text  = contentString
            }
        }
        self.present(alert, animated: true) {
            self.becomeFirstResponder()
        }
    }
    
    @IBAction func phoneNumber(_ sender: Any) {
        let alert = UIAlertController(title: "你的电话", message: "请输入你的电话号码", cancelButtonTitle: "cancel", okButtonTitle: "ok", validate: TextValidationRule.predicate({ Int($0) != nil }), textFieldConfiguration: { (textField) in
            self.emailField.isEqual(textField)
            textField.placeholder = "请输入电话"
            self.textFieldStyle(textField: textField)
        }) { [weak self] (textInputResult) in
            switch textInputResult {
            case .cancel:
                break
            case .ok(let contentString):
                self?.phoneField.text  = contentString
            }
        }
        self.present(alert, animated: true) {
            self.becomeFirstResponder()
        }
        
        
        
    }
    
    func textFieldStyle(textField: UITextField)  {
        textField.textColor = UIColor.randomColor
        textField.tintColor = UIColor.randomColor
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textAlignment = .left
        textField.clearButtonMode = .whileEditing
        textField.minimumFontSize = 12
        textField.keyboardAppearance = .alert
    }

}

