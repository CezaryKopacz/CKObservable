//
//  ViewController.swift
//  CKObservable-Example
//
//  Created by Cezary Kopacz on 24/06/2019.
//  Copyright © 2019 CezaryKopacz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var viewModel: ViewModel?
    var viewModelDisposeBag: CKDisposeBag?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel = ViewModel()
        viewModelDisposeBag = CKDisposeBag()
        
        guard let viewModel = self.viewModel, let viewModelDisposeBag = self.viewModelDisposeBag else { return }
        
        slider.value(bindTo: viewModel.sliderValue)
        sliderValueLabel.bind(to: viewModel.sliderValue.map { value in "Slider value: \(value ?? 0)" })
            .disposed(by: viewModelDisposeBag)
    }

}

