//
//  ViewController.swift
//  Voice Recorder
//
//  Created by Elizaveta Prokudina on 22.01.2020.
//  Copyright © 2020 Elizaveta Prokudina. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {
    
    var recorder: AVAudioRecorder!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    

    var recordURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButton.isEnabled = false
        recordButton.isEnabled = true
        setupRecorder()
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        recorder = nil
    }
    
    @IBAction func record(_ sender: Any) {
        print("\(#function)")
        
        if recorder == nil {
            print("recording. recorder nil")
            recordButton.isEnabled = false
            stopButton.isEnabled = true
        } else {
            print("recording")
            recordButton.isEnabled = false
            stopButton.isEnabled = true
            recorder.record()
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        print("\(#function)")
        
        recorder?.stop()

        let session = AVAudioSession.sharedInstance()
        do {
            try session.setActive(false)
            recordButton.isEnabled = true
            stopButton.isEnabled = false
        } catch {
            print("can't make session inactive")
            print(error.localizedDescription)
        }
    }
    
    func setupRecorder() {
        print("\(#function)")
        let currentFileName = UUID().uuidString + ".m4a"
        print(currentFileName)
        
        let documentsDirectory  = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        self.recordURL = documentsDirectory.appendingPathComponent(currentFileName)
        print("writing to soundfile url: '\(recordURL!)'")
        
        if FileManager.default.fileExists(atPath: recordURL.absoluteString) {
            print("\(recordURL.absoluteString) already exists")
        }
        let recordSettings: [String: Any] = [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
            AVEncoderBitRateStrategyKey: 3200,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0
        ]
        do {
            recorder = try AVAudioRecorder(url: recordURL, settings: recordSettings)
            recorder.delegate = (self as AVAudioRecorderDelegate)
            recorder.isMeteringEnabled = true
            recorder.prepareToRecord() // creates/overwrites the file at soundFileURL
        } catch {
            recorder = nil
            print(error.localizedDescription)
        }
    }
}



