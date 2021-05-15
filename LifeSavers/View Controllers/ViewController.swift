//
//  ViewController.swift
//  LifeSavers
//
//  Created by user167523 on 7/7/20.
//  Copyright © 2020 NoyD. All rights reserved.
//

import UIKit
import Firebase
import AVKit

class ViewController: UIViewController {
    
    //seuges are defined in Main.storyboard to make the movement between this VC to the other VC's
    @IBOutlet weak var mainVC_signUp_btn: UIButton!
    @IBOutlet weak var mainVC_signIn_btn: UIButton!
    
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleButtons()
        
    }
    
    func styleButtons() {
        mainVC_signUp_btn.layer.cornerRadius = 30.0
        mainVC_signUp_btn.layer.borderWidth = 3
        mainVC_signUp_btn.layer.borderColor = UIColor.systemBlue.cgColor
        mainVC_signUp_btn.backgroundColor = UIColor.white
        mainVC_signIn_btn.layer.cornerRadius = 30.0
        mainVC_signIn_btn.layer.borderWidth = 3
        mainVC_signIn_btn.layer.borderColor = UIColor.black.cgColor
        mainVC_signIn_btn.backgroundColor = UIColor.white
    }
}

