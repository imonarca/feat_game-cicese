//
//  ViewController.swift
//  camera
//
//  Created by Maria Fernanda Monarca Lopez  on 02/11/21.
//

import UIKit
import AVFoundation
class videoController: UIViewController {
    var session:AVCaptureSession?
    let output = AVCapturePhotoOutput()
    let videoOutput = AVCaptureMovieFileOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    /*
    private let shutterButton:UIButton={
        let button = UIButton(frame: CGRect(x:0,y:0,width:200, height: 200))
        button.layer.cornerRadius = 100
        button.layer.borderWidth = 3
        return button
      
    }()
*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        view.backgroundColor = .black
        previewLayer.backgroundColor = UIColor.systemRed.cgColor
        
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterButton)
        checkCameraPermissions()
        
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)*/
    }
    /*
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        shutterButton.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height-200)
    }
     */
    func checkCameraPermissions(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler:{
                [weak self] granted in guard
                    granted else { return}
                DispatchQueue.main.async {
                    self?.setupCamera()
                }
            })
        case .restricted:
            break
        case .authorized:
              setupCamera()
        
        default: break
        }
    }
    
    func setupCamera(){
        let session = AVCaptureSession()
    
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera,
            for: .video,
            position: .front){
            do {
                
            let input = try AVCaptureDeviceInput(device: device)
            if session.canAddInput(input){
                session.addInput(input)
            }
            
          if session.canAddOutput(videoOutput){
                    session.addOutput(videoOutput)
                }
                
        videoOutput.connection(with: .video)?.videoOrientation = .landscapeRight
        print("conetion")
      //previewLayer.videoGravity = .resizeAspect
      //previewLayer.session = session
     //previewLayer.connection?.videoOrientation = .portrait
        session.startRunning()
                
        self.session = session
                
        }
        catch { print(error)}
    }
    }

    
    func didTapTakePhoto(nameVideo:String){
          //"output.mov"
        /* output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)*/
        
        if videoOutput.isRecording {
            videoOutput.stopRecording()
            print("stoop recording")
        } else {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileUrl = paths[0].appendingPathComponent(nameVideo)
        try? FileManager.default.removeItem(at: fileUrl)
            videoOutput.startRecording(to: fileUrl, recordingDelegate: self as AVCaptureFileOutputRecordingDelegate)
        }
        }
   
        
    }
    
extension videoController: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput,
                    didFinishRecordingTo outputFileURL: URL,
                    from connections: [AVCaptureConnection],
                    error: Error?) {
        session?.stopRunning()
        
        if error == nil {
        UISaveVideoAtPathToSavedPhotosAlbum(outputFileURL.path, nil, nil, nil)
        }
      
    }
}
    
 /*

extension ViewController:
    
    AVCapturePhotoCaptureDelegate{
    
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else{
            return
        }
        let image = UIImage(data: data)
        session?.stopRunning()
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
        view.addSubview(imageView)
    }
    }
    */
  



