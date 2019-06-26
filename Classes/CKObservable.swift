//
//  CKObservable.swift
//  CKObservable
//
//  Created by Cezary Kopacz on 07/05/2019.
//  Copyright © 2019 Cezary Kopacz. All rights reserved.
//

import Foundation

final class CKObservable<T> {
    typealias Observer = (T?) -> Void
    private var observers: [String: (observer: Observer, queue: DispatchQueue)] = [:]
    private let lock = Lock()
    private let onDispose: () -> Void
    private let localQueue = DispatchQueue(label: "localQueue")
    
    private var _value: T? {
        didSet {
            let newValue = _value
            observers.values.forEach { pair in
                pair.queue.async {
                    pair.observer(newValue)
                }
            }
        }
    }
    
    var value: T? {
        get {
            return _value
        }
        set {
            lock.lock()
            _value = newValue
            lock.unlock()
        }
    }

    init(_ value: T?, onDispose: @escaping () -> Void = {}) {
        self._value = value
        self.onDispose = onDispose
    }
    
    func observe(_ observer: @escaping Observer) -> CKDisposable {
        return observeOn(localQueue, observer)
    }
    
    func observeOn(_ queue: DispatchQueue, _ observer: @escaping Observer) -> CKDisposable {
        lock.lock()
        let id = UUID().uuidString
        observers[id] = (observer, queue)
        
        observer(value)
        
        let disposable = CKDisposable { [weak self] in
            self?.lock.lock()
            self?.observers[id] = nil
            self?.onDispose()
            self?.lock.unlock()
        }
        
        lock.unlock()
        
        return disposable
    }
}

extension CKObservable {
    func map<U>(_ transform: @escaping (T?) -> U) -> CKObservable<U> {
        let new = CKObservable<U>(nil, onDispose: self.onDispose)
        _ = self.observe { (value) in
            new.value = transform(value)
        }
        
        return new
    }
}

