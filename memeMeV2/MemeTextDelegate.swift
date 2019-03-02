//
//  MemeTextDelegate.swift
//  imagePickerTest
//
//  Created by Frank Aceves on 1/19/18.
//  Copyright © 2018 Frank Aceves. All rights reserved.
//

import Foundation
import UIKit

class MemeTextDelegate: NSObject, UITextFieldDelegate {
    let memeTextAttributes: [String:Any] = [
        NSAttributedString.Key.strokeColor.rawValue : UIColor.black,
        NSAttributedString.Key.foregroundColor.rawValue : UIColor.white,
        NSAttributedString.Key.font.rawValue : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth.rawValue : -3.0
    ]
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
