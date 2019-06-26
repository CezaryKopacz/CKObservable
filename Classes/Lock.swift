//
//  Lock.swift
//  CKObservable
//
//  Created by Cezary Kopacz on 10/05/2019.
//  Copyright © 2019 Cezary Kopacz. All rights reserved.
//

import Foundation

final class Lock {
    private var mutex: pthread_mutex_t = {
        var mutex = pthread_mutex_t()
        pthread_mutex_init(&mutex, nil)
        return mutex
    }()
    
    func lock() {
        pthread_mutex_lock(&mutex)
    }
    func unlock() {
        pthread_mutex_unlock(&mutex)
    }
}
