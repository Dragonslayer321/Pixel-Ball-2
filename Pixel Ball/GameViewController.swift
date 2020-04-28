//
//  GameViewController.swift
//  Pixel Ball
//
//  Created by Adeel Din on 2019-09-03.
//  Copyright © 2019 Adeel Din. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GameKit
import GoogleMobileAds



class GameViewController: UIViewController, GADInterstitialDelegate {



    @IBOutlet var popUP: GADInterstitial!
    
    
    @IBOutlet var bannerView: GADBannerView!
    
    
    override func viewDidLoad() {
        GameScene().setRetryToOne()
        popUP = GADInterstitial(adUnitID: "ca-app-pub-5703932646795722/5569616528")
        popUP.delegate = self
        popUP = createAndLoadInterstitial()
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
        try? AVAudioSession.sharedInstance().setActive(true)
        super.viewDidLoad()
      
        NotificationCenter.default.addObserver(self, selector: #selector(notificationFired(_:)), name: NSNotification.Name("FIRENOTIFICATION"), object: nil)
        
        
        bannerView.adUnitID = "ca-app-pub-5703932646795722/9808723368"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
       self.button?.isHidden = false
        authenticateUser()
//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                // Present the scene
//                view.presentScene(scene)
//            }
//
//            view.ignoresSiblingOrder = true
//
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
    }
    

    func createAndLoadInterstitial() -> GADInterstitial {
        var popUP = GADInterstitial(adUnitID: "ca-app-pub-5703932646795722/5569616528")
        popUP.delegate = self
        popUP.load(GADRequest())
        return popUP
    }
    
    @IBOutlet var button: UIButton?
    
    @IBAction func button(_ sender: UIButton!) {
        let vc = GKGameCenterViewController()
        vc.gameCenterDelegate = self
        vc.viewState = .leaderboards
        vc.leaderboardIdentifier = "com.adeeldin.Pixel-Ball.Scores"
        present(vc, animated: true, completion: nil)
    }
    private func authenticateUser() {
        let userPlayer = GKLocalPlayer.local
        
        userPlayer.authenticateHandler = { vc, error in
            
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            if let vc = vc {
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    @objc func notificationFired(_ notification: Notification) {
        showPopUP()
    }
    func showPopUP(){

        if popUP.isReady {
            popUP.present(fromRootViewController: self)
          } else {
            print("Ad wasn't ready, Ad wasn't ready, Ad wasn't ready, Ad wasn't ready, Ad wasn't ready, Ad wasn't ready, Ad wasn't ready, Ad wasn't ready, Ad wasn't ready")
          }
    }
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
      print("interstitialDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
      print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
      print("interstitialWillPresentScreen")
    }

    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
      print("interstitialWillDismissScreen")
    }

    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
      print("interstitialDidDismissScreen")
        popUP = createAndLoadInterstitial()
    }

    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
      print("interstitialWillLeaveApplication")
    }
    //ca-app-pub-5703932646795722~7716433562

    
    func showLeaderBoardButton(){
//        button!.sendActions(for: .touchUpInside)
        button?.center = CGPoint(x: 190, y: 200)
        print("i work")
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameViewController:
GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
