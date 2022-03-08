//
//  ShakeBellView.swift
//  Bankey
//
//  Created by yeonBlue on 2022/03/08.
//

import UIKit
import SnapKit
import Then

class ShakeBellView: UIView {
    
    let imageView = UIImageView().then {
        $0.image = UIImage(systemName: "bell.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal)
        $0.isUserInteractionEnabled = true
    }

    let badgeButton = UIButton().then {
        $0.backgroundColor = .systemRed
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        $0.layer.cornerRadius = 8
        $0.setTitle("6", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 48, height: 48)
    }
}

extension ShakeBellView {
    
    private func setup() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(singleTap)
    }
    
    private func layout() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        addSubview(badgeButton)
        badgeButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.top)
            make.leading.equalTo(imageView.snp.trailing).offset(-8)
            make.width.height.equalTo(16)
        }
    }
    
    @objc func imageViewTapped(_ recognizer: UITapGestureRecognizer) {
        func shakeBell(duration: Double, angle: CGFloat, yOffset: CGFloat) {
              let numberOfFrames: Double = 6
              let frameDuration = Double(1/numberOfFrames)
              
              imageView.setAnchorPoint(CGPoint(x: 0.5, y: yOffset))

              UIView.animateKeyframes(withDuration: duration, delay: 0, options: [],
                animations: {
                  UIView.addKeyframe(withRelativeStartTime: 0.0,
                                     relativeDuration: frameDuration) {
                      self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
                  }
                  UIView.addKeyframe(withRelativeStartTime: frameDuration,
                                     relativeDuration: frameDuration) {
                      self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
                  }
                  UIView.addKeyframe(withRelativeStartTime: frameDuration * 2,
                                     relativeDuration: frameDuration) {
                      self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
                  }
                  UIView.addKeyframe(withRelativeStartTime: frameDuration * 3,
                                     relativeDuration: frameDuration) {
                      self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
                  }
                  UIView.addKeyframe(withRelativeStartTime: frameDuration * 4,
                                     relativeDuration: frameDuration) {
                      self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
                  }
                  UIView.addKeyframe(withRelativeStartTime: frameDuration * 5,
                                     relativeDuration: frameDuration) {
                      self.imageView.transform = CGAffineTransform.identity
                  }
                }
              )
          }
        
        shakeBell(duration: 1.0, angle: .pi / 6, yOffset: 0.1)
    }
}

extension UIView {
    
    /// 회전할 때 기본은 좌측상단이 기준이므로, 가운데를 기준으로 회전을 하려면 AnchorPoint를 변경해야 함
    /// - Parameter point: 새로운 Anchor 위치
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x,
                               y: bounds.size.height * point.y)
        
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x,
                               y: bounds.size.height * layer.anchorPoint.y)

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }
}
