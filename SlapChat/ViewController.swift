//
//  ViewController.swift
//  SlapChat
//
//  Created by Mark Rabins on 7/8/17.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: AAPLCameraViewController, AAPLCameraVCDelegate {

    @IBOutlet weak var previewView: AAPLPreviewView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    let userSegue = "UserSegue"
    
    override func viewDidLoad() {
        delegate = self
        _previewView = previewView

        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard Auth.auth().currentUser != nil else {
            performSegue(withIdentifier: "LoginVCSegue", sender: nil)
            return
        }
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
        performSegue(withIdentifier: userSegue, sender: ["videoURL": videoURL])
    }
    
    func videoRecordingFailed() {
        // Implement
    }
    
    func snapshotTaken(_ snapshotData: Data!) {
        performSegue(withIdentifier: userSegue, sender: ["snapshotData": snapshotData])
    }
    
    func snapshotFailed() {
        // implement
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let usersVC = segue.destination as? UsersVC {
            if let videoDict = sender as? Dictionary<String, URL> {
                let url = videoDict["videoURL"]
                usersVC.videoURL = url
            } else if let snapDict = sender as? Dictionary<String, Data> {
                let snapData = snapDict["snapshotData"]
                usersVC.snapData = snapData
            }
            
        }
    }
    
    
    
    
    
}

