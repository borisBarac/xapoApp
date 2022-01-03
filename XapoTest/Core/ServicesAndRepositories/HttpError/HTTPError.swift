//
//  HTTPError.swift
//  XapoTest
//
//  Created by Boris Barac on 02.01.2022.
//

import Foundation

enum HTTPError: LocalizedError {
    case statusCode(Int)
    case wrongUrl
    case serverDown
    case unknown(Error?)

    var errorDescription: String? {
        "Somethig went wrong"
    }

    var failureReason: String? {
        errorText
    }
    
    private var errorText: String? {
        func getText(code: Int) -> String {
            switch code {
            case 400..<500:
                return "Wrong params are send"
            case 500..<600:
                return "We can not reach the server"
            default:
                return "Something went wrong"
            }
        }

        switch self {
        case .statusCode(let code):
            return getText(code: code)
        case .wrongUrl:
            return "Wrong URL used"
        // case URLError.notConnectedToInternet.rawValue, URLError.cannotConnectToHost.rawValue:
        case .serverDown:
            return "No Internet connection"
        case .unknown(let error):
            return error?.localizedDescription ?? ""
        }
    }
}
