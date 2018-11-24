//
//  UIAlertController+TextField.swift
//  Swift -- fun
//
//  Created by aixuexue on 2018/11/20.
//  Copyright © 2018 WJQ. All rights reserved.
//

import Foundation
import UIKit

//输入文本的验证规则
public enum TextValidationRule {
    // 任何输入都是有效的，包括空字符串.
    case noRestriction
    // 输入必须非空
    case nonEmpty
     //输入的字符串匹配正则表达式
    case regularExpression(NSRegularExpression)
    //如果谓词函数返回' true '，则输入是有效的。
    case predicate((String) -> Bool)
    
    public func isValid(_ input : String) -> Bool {
        switch self {
        case .noRestriction:
            return true
        case .nonEmpty:
            return !input.isEmpty
        case .regularExpression(let regex):
            let fullNSRange = NSRange(input.startIndex..., in: input)
            return regex.rangeOfFirstMatch(in: input, options: .anchored, range: fullNSRange) == fullNSRange
        case .predicate(let p):
            return p(input)
        }
    }
}



extension UIAlertController {
    //点击
    public enum TextInputResult {
        case cancel  //cancel button 
        case ok(String)
    }
    
   
   
    //  - validationRule: The OK button will be disabled as long as the entered text doesn't pass the validation. The default value is `.noRestriction` (any input is valid, including an empty string).只要输入的文本没有通过验证，OK按钮就会被禁用。默认值是.noRestriction(任何输入都是有效的，包括一个空字符串)。
    //  - textFieldConfiguration: 设置弹出框中UITextField的属性
    //  - onCompletion: 当用户关闭警报视图时调用。该参数告诉您用户是单击了关闭按钮还是单击了OK按钮(在这种情况下，这将传递输入的文本)。
    public convenience init(title: String,
                                   message: String? = nil,
                     cancelButtonTitle: String,
                            okButtonTitle: String,
             validate validationRule: TextValidationRule = .noRestriction,
             textFieldConfiguration: ((UITextField) -> Void)? = nil,
                           onCompletion: @escaping (TextInputResult) -> Void)
    {
        //1.
        self.init(title: title, message: message, preferredStyle: .alert)
        
        
        //2.
        class TextFieldObserver: NSObject, UITextFieldDelegate {
            let textFieldValueChanged: (UITextField) -> Void
            let textFieldShouldReturn: (UITextField) -> Bool
            
            init(textField: UITextField, valueChanged: @escaping (UITextField) -> Void, shouldReturn: @escaping (UITextField) -> Bool) {
                self.textFieldValueChanged = valueChanged
                self.textFieldShouldReturn = shouldReturn
                super.init()
                textField.delegate = self
                textField.addTarget(self, action: #selector(TextFieldObserver.textFieldValueChanged(sender:)), for: .editingChanged)
            }
            
            @objc func textFieldValueChanged(sender: UITextField) {
                textFieldValueChanged(sender)
            }
            
            // MARK: UITextFieldDelegate
            func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                return textFieldShouldReturn(textField)
            }
        }
        
        //-----------//
        var textFieldObserver: TextFieldObserver?
        
        func finish(result: TextInputResult) {
            textFieldObserver = nil
            onCompletion(result)
        }
        
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: { _ in
            finish(result: .cancel)
        })
        let okAction = UIAlertAction(title: okButtonTitle, style: .default, handler: { [unowned self] _ in
            finish(result: .ok(self.textFields?.first?.text ?? ""))
        })
        addAction(cancelAction)
        addAction(okAction)
        preferredAction = okAction
        
        addTextField { (textField) in
            textFieldConfiguration?(textField)
            
            textFieldObserver =  TextFieldObserver(textField: textField, valueChanged: { (textField) in
                //ok 按钮是否可用(文本验证规则)
                okAction.isEnabled = validationRule.isValid(textField.text ?? "" )
                print("valueChanging......")
            }, shouldReturn: { (textField) -> Bool in
                validationRule.isValid(textField.text ?? "")
            })
        }
        //如果需要，从禁用的OK按钮开始
        okAction.isEnabled = validationRule.isValid(textFields?.first?.text ?? "")
        
    }
    
    
    
}
