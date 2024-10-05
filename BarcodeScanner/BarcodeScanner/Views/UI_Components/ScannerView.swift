//
//  ScannerView.swift
//  BarcodeScanner
//
//  Created by RAJAT DHIMAN on 21/07/24.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable{
 
    @Binding var scannedCode : String 
    @Binding var alertItem : AlertItem?
    
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerDelagate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {
  
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }
    
    
    final class Coordinator: NSObject, ScannerVCDelegate {
        
        private let scannerView : ScannerView
        
        init(scannerView: ScannerView) {
            self.scannerView = scannerView
        }
        
        func didFind(barCode: String) {
            scannerView.scannedCode = barCode
        }
        
        func didSurface(error: CameraError) {
            if(error == CameraError.invalidDeviceInput){
                scannerView.alertItem = AlertContext.invailDeviceInput
            }else {
                scannerView.alertItem = AlertContext.invailSacnnedValue
            }
        }
        
        
    }
    
   
    
    
}

#Preview {
    ScannerView(scannedCode: .constant("8758757") ,
                alertItem: .constant(AlertItem(title: "", message: "", dismissButton: .default(Text(""))))
    )
}
