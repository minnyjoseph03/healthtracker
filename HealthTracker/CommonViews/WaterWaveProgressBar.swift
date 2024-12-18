//
//  WaterWaveProgressBar.swift
//  HealthTracker
//
//  Created by Minny Joseph on 16/12/24.
//

import UIKit

let screenWidth = UIScreen.main.bounds.size.width

class WaterWaveProgressBar: UIView {
    
    private let firstLayer = CAShapeLayer()
    private let secondLayer = CAShapeLayer()
    
    private let percentLabel = UILabel()
    
    private var firstColor: UIColor = .clear
    private var secondColor: UIColor = .clear
    
    private let twom: CGFloat = .pi * 2
    private var offset: CGFloat = 0.0
    
    private let width = screenWidth * 0.5
    
    var showSingleWave = false
    private var start = false
    
    var progress: CGFloat = 0.0
    var waveHeight: CGFloat = 0.0
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }
    
    required init?(coder: NSCoder) {
            super.init(coder: coder)
    }
    

}

extension WaterWaveProgressBar {
    private func setupView() {
        bounds = CGRect(x: 0.0, y: 0.0, width: min(width, width), height: min(width, width))
        clipsToBounds = true
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = width / 2
        layer.masksToBounds = true
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        waveHeight = 8.0
        firstColor = .cyan
        secondColor = .cyan.withAlphaComponent(0.4)
        
        createFirstLayer()
        if !showSingleWave {
            createSecondLayer()
        }
        createPercentLabel()
    }
    
    private func createFirstLayer() {
        firstLayer.frame = bounds
        firstLayer.anchorPoint = .zero
        firstLayer.fillColor = firstColor.cgColor
        layer.addSublayer(firstLayer)
        
    }
    
    private func createSecondLayer() {
        secondLayer.frame = bounds
        secondLayer.anchorPoint = .zero
        secondLayer.fillColor = secondColor.cgColor
        layer.addSublayer(secondLayer)
    }
    
    private func createPercentLabel() {
        percentLabel.font = UIFont.boldSystemFont(ofSize: 35.0)
        percentLabel.textAlignment = .center
        percentLabel.text = "99%"
        percentLabel.textColor = UIColor(named: "c6")
        addSubview(percentLabel)
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        percentLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        percentLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func percentAnim() {
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.duration = 1.5
        anim.fromValue = 0.0
        anim.toValue = 1.0
        anim.repeatCount = .infinity
        anim.isRemovedOnCompletion = false
        
        percentLabel.layer.add(anim,forKey: nil)
    }
    
     func setupProgress(_ pr: CGFloat) {
        progress = pr
         percentLabel.text = String(format: "%.1f L", pr * 100)
        
        let top: CGFloat = pr * bounds.size.height
        firstLayer.setValue(width-top, forKey: "position.y")
        secondLayer.setValue(width-top, forKey: "position.y")
        
        if !start {
            DispatchQueue.main.async {
                self.startAnim()
            }
        }
    }
    
    private func startAnim() {
        start = true
        waterWaveAnim()
    }
    
    private func waterWaveAnim() {
        let w = bounds.size.width
        let h = bounds.size.height
        
        let bezier = UIBezierPath()
        let path = CGMutablePath()
        let startOffsetY = waveHeight * CGFloat(sinf(Float(offset * twom / w)))
        var originOffsetY: CGFloat = 0.0
        
        path.move(to: CGPoint(x: 0.0, y: startOffsetY), transform: .identity)
        bezier.move(to: CGPoint(x: 0.0, y: startOffsetY))
        
        for i in stride(from: 0.0, to: w * 1000, by: 1) {
            originOffsetY = waveHeight * CGFloat(sinf(Float(twom / w * i + offset * twom / w)))
            bezier.addLine(to: CGPoint(x: i, y: originOffsetY))
        }
        
        bezier.addLine(to: CGPoint(x:  w*1000, y: originOffsetY))
        bezier.addLine(to: CGPoint(x:  w*1000, y: h))
        bezier.addLine(to: CGPoint(x:  0.0, y: h))
        bezier.addLine(to: CGPoint(x:  0.0, y: startOffsetY))
        bezier.close()
        
        let anim = CABasicAnimation(keyPath: "transform.translation.x")
        anim.duration = 2.0
        anim.fromValue = -w*0.5
        anim.toValue = -w - w*0.5
        anim.repeatCount = .infinity
        anim.isRemovedOnCompletion = false
        
        firstLayer.fillColor = firstColor.cgColor
        firstLayer.path = bezier.cgPath
        firstLayer.add(anim, forKey: nil)
        
        if !showSingleWave {
            let bezier = UIBezierPath()
            
            let startOffsetY = waveHeight * CGFloat(sinf(Float(offset * twom / w)))
            var originOffsetY: CGFloat = 0.0
            
//            path.move(to: CGPoint(x: 0.0, y: startOffsetY), transform: .identity)
            bezier.move(to: CGPoint(x: 0.0, y: startOffsetY))
            
            for i in stride(from: 0.0, to: w*1000, by: 1) {
                originOffsetY = waveHeight * CGFloat(cosf(Float(twom / w * i + offset * twom / w)))
                bezier.addLine(to: CGPoint(x: i, y: originOffsetY))
            }
            
            bezier.addLine(to: CGPoint(x:  w*1000, y: originOffsetY))
            bezier.addLine(to: CGPoint(x:  w*1000, y: h))
            bezier.addLine(to: CGPoint(x:  0.0, y: h))
            bezier.addLine(to: CGPoint(x:  0.0, y: startOffsetY))
            bezier.close()
            
            secondLayer.fillColor = secondColor.cgColor
            secondLayer.path = bezier.cgPath
            secondLayer.add(anim, forKey: nil)
        }
       
    }
}
