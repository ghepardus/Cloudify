//
//  CustomError.swift
//  Cloudify
//
//  Created by Mario Severino on 22/08/22.
//

import UIKit

enum CustomError: Error {
    case GenericError(String?, Int? = nil)
    
    var errorDescription: String? {
        switch self {
        case .GenericError(let errorDescr, _):
            return errorDescr
        }
    }
    
    var errorCode: Int? {
        switch self {
        case .GenericError(_, let errorCode):
            return errorCode
        }
    }
}
