//
//  FirstVC.swift
//  StructClassDifference
//
//  Created by landixing on 2018/9/20.
//  Copyright © 2018年 WJQ. All rights reserved.
//

import UIKit

struct Book: Codable {
    var title : String?
    var author: String?
    var editor: String?
    var type: String?
    var date: String?
   
}

class FirstVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var table: UITableView!
    @IBOutlet var titleCell: UITableViewCell!
    @IBOutlet var authorCell: UITableViewCell!
    @IBOutlet var editorCell: UITableViewCell!
    @IBOutlet var typeCell: UITableViewCell!
    @IBOutlet var dateCell: UITableViewCell!
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var editorField: UITextField!
    @IBOutlet weak var typeFeild: UITextField!
    @IBOutlet weak var dateField: UITextField!
    lazy var bookModel = Book()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Codable 协议, 数据回显功能"
        table.tableFooterView = UIView()
        titleField.delegate = self
        authorField.delegate = self
        editorField.delegate = self
        typeFeild.delegate = self
        dateField.delegate = self
        
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        MobClick.event("3")
        MobClick.beginLogPageView("\(type(of: self))")
        do {

            guard let bookData = UserDefaults.standard.object(forKey: "BookInfo") as? Data else { return  }
            let model =  try JSONDecoder().decode(Book.self, from: bookData)
            self.bookModel = model
            titleField.text = model.title
            authorField.text = model.author
            editorField.text = model.editor
            typeFeild.text = model.type
            dateField.text = model.date
            self.table.reloadData()
        } catch {
            print(error.localizedDescription)
        }
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        MobClick.endLogPageView("\(type(of: self))")
        self.view.endEditing(true)
        do {
            let data = try JSONEncoder().encode(self.bookModel)
            UserDefaults.standard.setValue(data, forKey: "BookInfo")
            UserDefaults.standard.synchronize()
            print(String(format: "%@", String(data: UserDefaults.standard.object(forKey: "BookInfo") as! Data, encoding: String.Encoding.utf8)!))
        } catch let error as NSError {
            print(error.userInfo)
        }
        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    @IBAction func push(_ sender: Any) {
        
        let secondVC = SecondVC()
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let temp = string.components(separatedBy: CharacterSet.whitespaces).joined(separator: "")
        if string != temp {
            return false
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if titleField == textField {
            titleField.text = textField.text
            self.bookModel.title = titleField.text
        } else if authorField == textField {
            authorField.text = textField.text
            self.bookModel.author = authorField.text
        }else if editorField == textField {
            editorField.text = textField.text
            self.bookModel.editor = editorField.text
        }else if typeFeild == textField {
            typeFeild.text = textField.text
            self.bookModel.type = typeFeild.text
        }else if dateField == textField {
            dateField.text = textField.text
            self.bookModel.date = dateField.text
        }
        
    }
    
}



extension FirstVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return self.titleCell
        case 1:
            return self.authorCell
        case 2:
            return self.editorCell
        case 3:
            return self.typeCell
        case 4:
            return self.dateCell
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


