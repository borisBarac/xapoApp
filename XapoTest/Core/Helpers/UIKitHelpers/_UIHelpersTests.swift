//
//  _UIHelpersTests.swift
//  XapoTestTests
//
//  Created by Boris Barac on 03.01.2022.
//

import XCTest
@testable import XapoTest

class _UIHelpersTests: XCTestCase {
    func testExample() throws {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = VC1()
        let scene = UIApplication.shared.connectedScenes.first! as! UIWindowScene
        window.windowScene = scene
        window.makeKeyAndVisible()

        let exp = XCTestExpectation(description: "Root changed")
        window.switch(rootViewController: VC2(), animated: true) {
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
        XCTAssertTrue(window.rootViewController is VC2)
    }
}

extension _UIHelpersTests {
    private class VC1: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .green
        }
    }
    private class VC2: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .blue
        }
    }
}
