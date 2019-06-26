//
//  CKDisposeBag.swift
//  CKObservable
//
//  Created by Cezary Kopacz on 10/05/2019.
//  Copyright © 2019 Cezary Kopacz. All rights reserved.
//

import Foundation

final class CKDisposeBag {
    private var disposables: [Disposable] = []
    private let lock = Lock()
    
    deinit {
        dispose()
    }
    
    func add(_ disposable: Disposable) {
        disposables.append(disposable)
    }
    
    private func dispose() {
        lock.lock()
        disposables.forEach { (disposable) in
            disposable.dispose()
        }
        lock.unlock()
    }    
}
