//
//  ViewController.swift
//  PlayLocalVideo
//
//  Created by Mac on 2019/7/15.
//  Copyright © 2019年 Mac. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer
class ViewController: UIViewController,AVAudioPlayerDelegate {

    var audioPlayer:AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let videoBtn = UIButton()
        videoBtn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        videoBtn.setTitle("Play Video", for: UIControlState.normal)
        videoBtn.frame = CGRect(x:50, y:50, width:100, height:50)
        self.view.addSubview(videoBtn)
        
        videoBtn .addTarget(self, action: #selector(playVideo), for: UIControlEvents.touchUpInside)
        
        let audioPlayBtn = UIButton()
        audioPlayBtn.setTitleColor(UIColor.red, for: UIControlState.normal)
        audioPlayBtn.setTitle("Play Audio", for: UIControlState.normal)
        audioPlayBtn.frame = CGRect(x:50, y:150, width:100, height:50)
        self.view.addSubview(audioPlayBtn)
        
        audioPlayBtn .addTarget(self, action: #selector(playAudio), for: UIControlEvents.touchUpInside)
        
        let audioPauseBtn = UIButton()
        audioPauseBtn.setTitleColor(UIColor.red, for: UIControlState.normal)
        audioPauseBtn.setTitle("Pause Audio", for: UIControlState.normal)
        audioPauseBtn.frame = CGRect(x:50,y:250,width:100,height:50)
        self.view.addSubview(audioPauseBtn)
        audioPauseBtn .addTarget(self, action: #selector(pauseAudio), for: UIControlEvents.touchUpInside)
        initAudio()
        UIApplication.shared.beginReceivingRemoteControlEvents()
        initForLockScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @objc func playVideo(){
        let videoUrl = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!
        let player = AVPlayer(url: videoUrl)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true, completion: {})
    }
    
        func initAudio() {
        let audioPath = Bundle.main.path(forResource: "test", ofType: "mp3")
        let audioUrl = URL(fileURLWithPath: audioPath!)
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
        }catch{
            audioPlayer = nil
        }
        
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
            try AVAudioSession.sharedInstance().setActive(true)
        }catch{
            print("error")
        }
    }
    
    func initForLockScreen(){
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyTitle:"绿色",
            MPMediaItemPropertyArtist:"雪伊",
            MPMediaItemPropertyArtwork:MPMediaItemArtwork(image: UIImage(named: "thumb.jpg")!),
            MPNowPlayingInfoPropertyPlaybackRate:1.0,
            MPMediaItemPropertyPlaybackDuration:audioPlayer?.duration,
            MPNowPlayingInfoPropertyElapsedPlaybackTime:audioPlayer?.currentTime
        ]
    }
    
    @objc func playAudio(){
        audioPlayer?.play()
    }
    
    @objc func pauseAudio(){
        audioPlayer?.pause()
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        switch event!.subtype {
        case .remoteControlPlay:
            audioPlayer?.play()
        case .remoteControlPause:
            audioPlayer?.pause()
        case .remoteControlStop:
            audioPlayer?.stop()
        default:
            break
        }
    }
}

