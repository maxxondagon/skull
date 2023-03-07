//
//  ViewController.swift
//  skull
//
//  Created by Maxim Soloboev on 07.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }
    
    let animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear)
    
    //MARK: - Elements
    
    lazy var square: UIView = {
        let square = UIView()
        let squareSide = view.frame.width * 0.2
        square.frame = CGRect(
            x: view.layoutMargins.left,
            y: 100,
            width: squareSide,
            height: squareSide
        )
        square.backgroundColor = .systemOrange
        square.layer.cornerRadius = 5
        let endPoint = CGRect(
            x: view.frame.width - square.frame.width * 1.5,
            y: square.frame.origin.y,
            width: square.frame.width,
            height: square.frame.height
        )
        animator.pausesOnCompletion = true
        animator.addAnimations {
            square.frame = endPoint
            square.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2).scaledBy(x: 1.5, y: 1.5)
        }
        return square
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.frame = CGRect(
            x: view.layoutMargins.left,
            y: square.bounds.width * 1.5 + 120,
            width: view.frame.width - view.layoutMargins.left - view.layoutMargins.right,
            height: 20
        )
        slider.thumbTintColor = .systemOrange
        slider.minimumTrackTintColor = .systemOrange
        slider.maximumTrackTintColor = .systemGray4
        slider.addTarget(self, action: #selector(self.changeValue(sender:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(releaseSlider), for: .touchUpInside)
        return slider
    }()
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(slider)
        view.addSubview(square)
    }
    
    private func setupLayout() {
        view.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    @objc func changeValue (sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }
    
    @objc func releaseSlider () {
        if animator.isRunning {
            slider.value = Float(animator.fractionComplete)
        }
        slider.setValue(slider.maximumValue, animated: true)
        animator.startAnimation()
    }
}

