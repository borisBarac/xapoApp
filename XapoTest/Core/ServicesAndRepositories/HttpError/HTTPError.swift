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

extension HTTPError: Equatable {
    static func == (lhs: HTTPError, rhs: HTTPError) -> Bool {
        switch lhs {
        case .statusCode(let Lint):
            switch rhs {
            case .statusCode(let Rint):
                return Lint == Rint
            default:
                return false
            }

        case .wrongUrl:
            switch rhs {
            case .wrongUrl:
                return true
            default:
                return false
            }

        case .serverDown:
            switch rhs {
            case .serverDown:
                return true
            default:
                return false
            }

        case .unknown(let Loptional):
            switch rhs {
            case .unknown(let Roptional):
                return Loptional?.localizedDescription == Roptional?.localizedDescription
            default:
                return false
            }
        }
    }


}
