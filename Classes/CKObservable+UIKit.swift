//
//  CKObservable+UIKit.swift
//  CKObservable
//
//  Created by Cezary Kopacz on 10/05/2019.
//  Copyright © 2019 Cezary Kopacz. All rights reserved.
//

import UIKit

extension UILabel {
    func bind(to: CKObservable<String>) -> CKDisposable {
        return to.observeOn(.main) { [weak self] value in
            self?.text = value
        }
    }
}

extension UITextView {
    func bind(to: CKObservable<String>) -> CKDisposable {
        return to.observeOn(.main) { [weak self] value in
            self?.text = value
        }
    }
}

fileprivate class ActionWrapper {
    let action: () -> Void
    init(_ action: @escaping () -> Void) {
        self.action = action
    }
    
    @objc func invoke() {
        action()
    }
}

extension UISegmentedControl {
    private func addAction( _ action: @escaping ()-> Void, for controlEvents: UIControl.Event) {
        let actionBoxed = ActionWrapper(action)
        addTarget(actionBoxed, action: #selector(ActionWrapper.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), actionBoxed, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func selectedIndex(bindTo: CKObservable<Int>) {
        addAction({ [unowned self] in
            let index = self.selectedSegmentIndex
            bindTo.value = index
            }, for: .valueChanged)
    }
}

extension UIImageView {
    func bind(to: CKObservable<UIImage>) -> CKDisposable {
        return to.observeOn(.main) { [weak self] image in
            self?.image = image
        }
    }
}

extension UIActivityIndicatorView {
    func bind(to: CKObservable<Bool>) -> CKDisposable {
        return to.observeOn(.main) { [weak self] loading in
            if let loading = loading {
                loading ? self?.startAnimating() : self?.stopAnimating()
            }
        }
    }
}

extension UISlider {
    private func addAction( _ action: @escaping ()-> Void, for controlEvents: UIControl.Event) {
        let actionBoxed = ActionWrapper(action)
        addTarget(actionBoxed, action: #selector(ActionWrapper.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), actionBoxed, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func value(bindTo: CKObservable<Float>) {
        addAction({ [unowned self] in
            bindTo.value = self.value
            }, for: .valueChanged)
    }
}
