//
//  ExtensionsH.swift
//  TestC
//
//  Created by móviles 2 on 10/02/22.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

extension MDCOutlinedTextField{
    
    func customPropiertiesControllerOnTextFields(placeholder: String,labelTextHelper:String){
        
        
        self.placeholder = placeholder
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                        attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2039215686, green: 0.2862745098, blue: 0.3333333333, alpha: 0.6)])
        self.floatingLabelColor(for: MDCTextControlState.editing)
        self.setOutlineColor(.darkGray, for: MDCTextControlState.normal)
        self.setOutlineColor(.darkGray, for: MDCTextControlState.editing)
        self.label.text = labelTextHelper
        self.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
       
        
        
    }
}
extension DateFormatter {
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter
    }()
    
        static let dayMonthNameYearFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            //dateFormatter.locale = Locale(identifier: "es")
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "dd MMM YYYY"
            return dateFormatter
        }()
}
