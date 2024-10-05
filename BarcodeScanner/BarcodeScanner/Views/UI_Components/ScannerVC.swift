//
//  SacnnerVC.swift
//  BarcodeScanner
//
//  Created by RAJAT DHIMAN on 21/07/24.
//

import UIKit
import AVFoundation


enum CameraError {
    case invalidDeviceInput
    case invalidScannedValue
}

protocol ScannerVCDelegate : AnyObject {
    func didFind(barCode : String )
    func didSurface(error : CameraError)
}


final class ScannerVC : UIViewController{
    
    let capturedSession = AVCaptureSession()
    
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelegate: ScannerVCDelegate?
    
    init( scannerDelagate : ScannerVCDelegate){
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelagate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureession()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let previewLayer = previewLayer else {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        previewLayer.frame = view.layer.bounds
    }
    
    
    private func setupCaptureession(){
        
        guard let videoCaptureVideo = AVCaptureDevice.default(for: .video) else {
            scannerDelegate?.didSurface(error: CameraError.invalidDeviceInput)
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureVideo)
        }catch {
            scannerDelegate?.didSurface(error: CameraError.invalidDeviceInput)
            return
        }
        
        
        if capturedSession.canAddInput(videoInput){
            capturedSession.addInput(videoInput)
        }else {
            scannerDelegate?.didSurface(error: CameraError.invalidDeviceInput)
         return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        if capturedSession.canAddOutput(metaDataOutput){
            capturedSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue:DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.ean8 , .ean13]
            
        }else {
            scannerDelegate?.didSurface(error: CameraError.invalidDeviceInput)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: capturedSession)
        
        previewLayer!.videoGravity = .resizeAspectFill
        
        view.layer.addSublayer(previewLayer!)
        
        capturedSession.startRunning()
        
        
    }
    

}


extension ScannerVC : AVCaptureMetadataOutputObjectsDelegate{
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else {
            scannerDelegate?.didSurface(error: CameraError.invalidScannedValue)
            return
        }
        
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
            scannerDelegate?.didSurface(error: CameraError.invalidScannedValue)

            return
        }
        
        guard let barcode = machineReadableObject.stringValue else {
            scannerDelegate?.didSurface(error: CameraError.invalidScannedValue)

            return
        }
        
        scannerDelegate?.didFind(barCode: barcode)
    }
    
}
