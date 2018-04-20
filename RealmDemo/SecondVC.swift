//
//  SecondVC.swift
//  RealmDemo
//
//  Created by MuhammadKhan on 4/18/18.
//  Copyright © 2018 MuhammadKhan. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {

    @IBOutlet weak var noteTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        if noteTF.text != "" {
            let item = Item()
            item.note = noteTF.text!
            item.ID = Int(arc4random_uniform(10000))
            DBManager.shared.addItem(object: item)
        }
        navigationController?.popViewController(animated: true)
    }
}
