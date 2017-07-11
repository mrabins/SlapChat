//
//  ViewController.swift
//  SlapChat
//
//  Created by Mark Rabins on 7/8/17.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class ViewController: AAPLCameraViewController, AAPLCameraVCDelegate {

    @IBOutlet weak var previewView: AAPLPreviewView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        delegate = self
        _previewView = previewView

        super.viewDidLoad()

    }

    @IBAction func changeCameraButtonTapped(_ sender: Any) {
        changeCamera()
    }
 
    
    @IBAction func recordButtonTapped(_ sender: Any) {
        toggleMovieRecording()
    }
    
    func shouldEnableCameraUI(_ enable: Bool) {
        cameraButton.isEnabled = enable
        print("Should enable camera UI: \(enable)")
    }
    
    func shouldEnableRecordUI(_ enable: Bool) {
        recordButton.isEnabled = enable
        print("should enabled record UI \(enable)")
    }
    
    func recordingHasStarted() {
        print("Recording has started")
    }
    
    func canStartRecording() {
        print("can start recording")
    }
    
    func videoRecordingComplete(_ videoURL: URL!) {
        // Implement
    }
    
    func videoRecordingFailed() {
        // Implement
    }
    
    func snapshotTaken(_ snapshotData: Data!) {
        // Implement
    }
    
    func snapshotFailed() {
        // implement
    }
}

