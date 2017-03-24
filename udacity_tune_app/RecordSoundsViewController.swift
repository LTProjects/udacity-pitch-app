//
//  RecordSoundsViewController.swift
//  udacity_tune_app
//
//  Created by Lev Tsenovoy on 2/17/17.
//  Copyright © 2017 Lev Tsenovoy. All rights reserved.
//

//var x: Int = 0;

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    var audioRecorder: AVAudioRecorder!

    @IBAction func recordAudio(_ sender: Any) {
        //print("record button was pressed ");
        recordingLabel.text = "Recording in Progress"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath!)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func stopRecording(_ sender: Any) {
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        recordingLabel.text = "Tap to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{

            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            print("Recording Failed!!!")
        }
    }//audioRecorderDidFinishRecording

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Stop Recording"{
        let playSoundVC = segue.destination as! PlaySoundsViewController
        let recordButtonURL = sender as! URL
            playSoundVC.recordedAudioURL = recordButtonURL
        }
    }
}

