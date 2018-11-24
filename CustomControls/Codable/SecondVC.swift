//
//  SecondVC.swift
//  StructClassDifference
//
//  Created by landixing on 2018/9/20.
//  Copyright © 2018年 WJQ. All rights reserved.
//

import UIKit

struct Info: Codable {
    var title : String?
    var content: String?
}

class SecondVC: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    lazy var infoModel = Info()
    var tempData =  Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "数据回显 (Codable)"
        textField.delegate = self
        textView.delegate = self
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        MobClick.beginLogPageView("\(type(of: self))")
        do {
            guard let data = UserDefaults.standard.object(forKey: "InfoData") as? Data else { return }
            let model =  try JSONDecoder().decode(Info.self, from: data)
            self.infoModel = model
            textField.text = model.title
            textView.text = model.content
        } catch {
            print(error.localizedDescription)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        MobClick.endLogPageView("\(type(of: self))")
        self.view.endEditing(true)
        do {
            let data = try JSONEncoder().encode(self.infoModel)
            UserDefaults.standard.setValue(data, forKey: "InfoData")
            UserDefaults.standard.synchronize()
            print(String(format: "%@", String(data: UserDefaults.standard.object(forKey: "InfoData") as! Data, encoding: String.Encoding.utf8)!))

        } catch let error as NSError {
            print(error.userInfo)
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    

}

extension SecondVC: UITextFieldDelegate, UITextViewDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.textField == textField {
             self.textField .text = textField.text
             self.infoModel.title = self.textField.text
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.textView == textView {
            self.textView.text = textView.text
            self.infoModel.content = self.textView.text
        }
    }
}

