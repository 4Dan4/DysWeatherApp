//
//  TextFieldExt.swift
//  DysWeatherApp
//
//  Created by dan4 on 12.06.2022.
//

import UIKit

// MARK: - UITextFieldDelegate
extension CitiesListView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addCity()
        return true
    }
    
}
