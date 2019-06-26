//
//  CKDisposeBagTests.swift
//  CKObservable
//
//  Created by Cezary Kopacz on 10/05/2019.
//  Copyright © 2019 Cezary Kopacz. All rights reserved.
//

import XCTest

class CKDisposeBagTests: XCTestCase {
 
    func testDisposeBagAdd() {
        var disposeBag: CKDisposeBag? = CKDisposeBag()
        
        let disposable = TestDisposable()
        let disposable2 = TestDisposable()
        disposeBag?.add(disposable)
        disposeBag?.add(disposable2)

        XCTAssert(disposable.count == 0)
        XCTAssert(disposable2.count == 0)
        
        disposeBag = nil
        
        XCTAssert(disposable.count == 1)
        XCTAssert(disposable2.count == 1)
    }
}

private class TestDisposable: Disposable {
    var count = 0
    func dispose() {
        count += 1
    }
}
