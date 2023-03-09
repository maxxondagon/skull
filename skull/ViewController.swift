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
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }

    //MARK: - Elements
    
    let animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear)
    let squareSide: CGFloat = 75
    
    lazy var square: UIView = {
        let square = UIView()
        let scale = CGFloat(1.5)
        square.backgroundColor = .systemOrange
        square.layer.cornerRadius = 5
        animator.addAnimations { [self] in
            square.frame = square.frame.offsetBy(
                dx: view.frame.width - squareSide * scale - view.layoutMargins.right,
                dy: 0
            )
            square.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2).scaledBy(x: scale, y: scale)
        }
        animator.pausesOnCompletion = true
        return square
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
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
        
        NSLayoutConstraint.activate([
            square.heightAnchor.constraint(equalToConstant: squareSide),
            square.widthAnchor.constraint(equalToConstant: squareSide),
            square.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            square.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),

            slider.topAnchor.constraint(equalTo: square.bottomAnchor, constant: 50),
            slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    @objc func changeValue (sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }
    
    @objc func releaseSlider () {
        slider.setValue(slider.maximumValue, animated: true)
        animator.startAnimation()
    }
}

