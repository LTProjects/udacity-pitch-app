//
//  PlaySoundsViewController.swift
//  udacity_tune_app
//
//  Created by Lev Tsenovoy on 3/21/17.
//  Copyright © 2017 Lev Tsenovoy. All rights reserved.
//

import UIKit
import AVFoundation
class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    var audioPlayer: AVAudioPlayer!

    enum ButtonType: Int { case slow = 0, fast = 1, chipmunk = 2, vader = 3, echo = 4, reverb = 5 }
    
    @IBAction func playSoundForButton(_ sender: UIButton){
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject){
        
        stopAudio()
        //print("Stop button was pressed");
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // setupAudio()
        if let filePath = Bundle.main.path(forResource: "movie_quote", ofType: "mp3") {
            let filePathUrl = NSURL.fileURL(withPath: filePath)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: filePathUrl, fileTypeHint: nil)
            } catch {
                print(error)
            }
            // do { audioPlayer = try AVAudioPlayer(contentsOfURL: filePath, fileTypeHint: nil) } catch _ { return print("file not found") }
            // audioPlayer = try! AVAudioPlayer(contentsOfURL: filePath, fileTypeHint: nil)
        } else {
            print("the filePath is empty")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }

}
