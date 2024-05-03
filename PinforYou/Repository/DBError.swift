//
//  DBError.swift
//  PinforYou
//
//  Created by 박진성 on 5/2/24.
//

import Foundation

enum DBError : Error {
    case error(Error)
    case emptyValue
    case invalidatedType
}
