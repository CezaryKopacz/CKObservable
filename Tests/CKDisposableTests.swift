//
//  CKDisposableTests.swift
//  CKObservable
//
//  Created by Cezary Kopacz on 10/05/2019.
//  Copyright © 2019 Cezary Kopacz. All rights reserved.
//

import XCTest

class CKDisposableTests: XCTestCase {
    
    func testActionDisposable() {
        var counter = 0
        
        let disposable = CKDisposable {
            counter += 1
        }
        
        XCTAssert(counter == 0)
        disposable.dispose()
        XCTAssert(counter == 1)
        disposable.dispose()
        XCTAssert(counter == 1)
    }
}
