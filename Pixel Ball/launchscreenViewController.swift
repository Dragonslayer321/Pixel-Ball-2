////
////  GameViewController.swift
////  Pixel Ball
////
////  Created by Adeel Din on 2019-09-03.
////  Copyright © 2019 Adeel Din. All rights reserved.
////
//
//import UIKit
//import SpriteKit
//import GameplayKit
//import GameKit
//import GoogleMobileAds
//
//
//
//class launchscreenViewController: UIView {
//
//
//    @IBOutlet weak var heartImageView: UIImageView!
//
//        var heartImages: [UIImage] = []
//
//    override func didMoveToSuperview() {
//        heartImages = createImageArray(total: 36, imagePrefix: "logo")
//        animate(imageView: heartImageView, images: heartImages)
//
//
//    }
//
//        // Can be refactored to an extension on Array.
//        func createImageArray(total: Int, imagePrefix: String) -> [UIImage] {
//
//            var imageArray: [UIImage] = []
//
//            for imageCount in 0..<total {
//                let imageName = "\(imagePrefix)-\(imageCount).png"
//                let image = UIImage(named: imageName)!
//
//                imageArray.append(image)
//            }
//            return imageArray
//        }
//
//        // Can be refactored to an extension on UIImage
//        func animate(imageView: UIImageView, images: [UIImage]) {
//            imageView.animationImages = images
//            imageView.animationDuration = 1.0
//            imageView.animationRepeatCount = 1
//            imageView.startAnimating()
//        }
//
//
//    }
//
