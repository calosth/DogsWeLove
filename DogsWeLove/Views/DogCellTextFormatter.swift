//
//  File.swift
//  DogsWeLove
//
//  Created by Carlos Linares on 25/01/20.
//  Copyright © 2020 Carlos Linares. All rights reserved.
//

import Foundation

struct DogCellTextFormatter {
    static func textFor(age: Int) -> String {
        let formatString: String = NSLocalizedString("DogCell.Age", comment: "")
        return String.localizedStringWithFormat(formatString, age, age)
    }
}
