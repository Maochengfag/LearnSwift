//
//  CenterViewController.swift
//  snapChatLikeAppV1
//
//  Created by Mac on 2019/7/21.
//  Copyright © 2019年 Mac. All rights reserved.
//

import UIKit
import AVFoundation

class CenterViewController: UIViewController,AVCapturePhotoCaptureDelegate{

    var imageView: UIImageView!
    var captureSession: AVCaptureSession!
    var stillImageOut: AVCapturePhotoOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        self.imageView = UIImageView(frame: self.view.bounds)
        self.view.addSubview(self.imageView)
        
        let captureBtn = UIButton()
        captureBtn.frame.size = CGSize(width: 100, height: 100)
        
        captureBtn.center.x = self.view.center.x
        captureBtn.frame.origin.y = self.view.frame.height - 100
        captureBtn.setImage(UIImage(named: "takePhoto"), for: UIControlState.normal)
//        captureBtn.addTarget(self, action: #selector(takePhoto), for: UIControlEvents.touchUpInside)
        self.view.addSubview(captureBtn)
        
//        let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back)
//        do {
//            let input = try AVCaptureDeviceInput(device: device!)
//            if (captureSession.canAddInput(input)){
//                captureSession.addInput(input)
//                stillImageOut = AVCapturePhotoOutput()
//                if (captureSession.canAddOutput(stillImageOut)){
//                    captureSession.addOutput(stillImageOut)
//
//                    let captureVideoLayer : AVCaptureVideoPreviewLayer =
//                        AVCaptureVideoPreviewLayer.init(session:captureSession  )
//                    captureVideoLayer.frame = self.imageView.bounds
//                    captureVideoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//                    self.imageView.layer.addSublayer(captureVideoLayer)
//
//                    captureSession.startRunning()
//                }
//            }
//        }
//
//        catch {
//            print(error)
//        }
    }
    
    @objc func takePhoto(_ sender: Any){
        DispatchQueue.main.async {
            self.view.layer.opacity = 0
            UIView.animate(withDuration: 0.25, animations: {
                self.view.layer.opacity = 1
            })
        }
        
        let settingForMonitoring = AVCapturePhotoSettings()
        settingForMonitoring.flashMode = .auto
        settingForMonitoring.isAutoStillImageStabilizationEnabled = false
        stillImageOut?.capturePhoto(with: settingForMonitoring, delegate:self)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if photoSampleBuffer != nil{
            //[AVCapturePhoto fileDataRepresentation]
            let photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
            let image = UIImage(data: photoData!)
            
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
