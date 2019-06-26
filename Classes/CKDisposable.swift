//
//  CKDisposable.swift
//  CKObservable
//
//  Created by Cezary Kopacz on 10/05/2019.
//  Copyright © 2019 Cezary Kopacz. All rights reserved.
//

import Foundation

protocol Disposable {
    func dispose()
}

final class CKDisposable: Disposable {
    fileprivate enum DisposeState: Int {
        case create = 0
        case disposed = 1
        case disposableSet = 2
    }
    
    private var disposeState: DisposeState = .create
    private var lock = Lock()
    typealias Dispose = () -> Void
    private let onDispose: Dispose
    private var isDisposed: Bool {
        return disposeState == .disposed
    }
    
    init(_ onDispose: @escaping Dispose) {
        lock.lock()
        self.onDispose = onDispose
        disposeState = .disposableSet
        lock.unlock()
    }
    
    func dispose() {
        guard disposeState == .disposableSet else { return }
        defer { lock.unlock() }
        lock.lock()
        onDispose()
        disposeState = .disposed
    }
    
    func disposed(by disposeBag: CKDisposeBag) {
        disposeBag.add(self)
    }
}
