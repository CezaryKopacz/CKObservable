//
//  CKObservableTests.swift
//  CKObservable
//
//  Created by Cezary Kopacz on 10/05/2019.
//  Copyright © 2019 Cezary Kopacz. All rights reserved.
//

import XCTest

class CKObservableTests: XCTestCase {
    
    func testObservableSubscribe() {
        let observable = CKObservable(0)
        var count = 0
        
        _ = observable.observe { value in
            count += 1
            XCTAssert(value == 0)
        }
        
        XCTAssert(count == 1)
    }
    
    func testObservableObserveEventOrder() {
        let values = [1,2,3]
        var expectedValues: [Int] = []
        
        XCTAssert(expectedValues.count == 0)
        
        let wait = expectation(description: "wait")
        
        let observable = CKObservable(0)
        _ = observable.observe { (value) in
            if let value = value {
                expectedValues.append(value)
                if value == values.last! {
                    wait.fulfill()
                }
            } else {
                XCTFail()
            }
        }

        values.forEach { (value) in
            observable.value = value
        }
        
        waitForExpectations(timeout: 0.5) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
        
        if expectedValues.count != 4 {
            XCTFail()
        } else {
            XCTAssert(expectedValues[0] == 0)
            XCTAssert(expectedValues[1] == 1)
            XCTAssert(expectedValues[2] == 2)
            XCTAssert(expectedValues[3] == 3)
        }
    }
    
    func testObserveOnDispatchQueue() {
        var didExecute = false

        let unitTestsThread = Thread.current
        
        let observable = CKObservable(0)
        _ = observable.observe { (value) in
            didExecute = true
            XCTAssert(Thread.current == unitTestsThread)
        }

        XCTAssert(didExecute)
    }
}
