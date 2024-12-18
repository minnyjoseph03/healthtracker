//
//  ViewController.swift
//  HealthTracker
//
//  Created by Minny Joseph on 16/12/24.
//

import UIKit

class ViewController: UIViewController {

    var waterWaveView = WaterWaveProgressBar()
    let dr: TimeInterval = 10.0
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(waterWaveView)
        waterWaveView.setupProgress(waterWaveView.progress)
        
        NSLayoutConstraint.activate([
            waterWaveView.widthAnchor.constraint(equalToConstant: screenWidth * 0.5),
            waterWaveView.heightAnchor.constraint(equalToConstant: screenWidth * 0.5),
            waterWaveView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            waterWaveView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
            let dr = CGFloat(1.0 / (self.dr / 0.01))
            self.waterWaveView.progress += dr
            self.waterWaveView.setupProgress(self.waterWaveView.progress)
            
            if self.waterWaveView.progress >= 0.95 {
                self.timer?.invalidate()
                self.timer = nil
            }
        })
    }

}

