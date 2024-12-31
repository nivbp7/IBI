//
//  String+Utils.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import Foundation

extension String {
    var trim: String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
}
