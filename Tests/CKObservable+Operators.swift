//
//  CKObservable+Operators.swift
//  CKObservable
//
//  Created by Cezary Kopacz on 10/05/2019.
//  Copyright © 2019 Cezary Kopacz. All rights reserved.
//

import XCTest

class CKObservableOperatorsTests: XCTestCase {
    
    func testMap() {
        
        var strings: [String] = []
        
        XCTAssert(strings.count == 0)
        
        let observable = CKObservable(0)
        _ = observable.map { (number) -> String in
            XCTAssertNotNil(number)
            return "\(number!)"
            }.observe { value in
                XCTAssertNotNil(value)
                strings.append(value!)
            }

        XCTAssert(strings.count == 1)
    }
}
