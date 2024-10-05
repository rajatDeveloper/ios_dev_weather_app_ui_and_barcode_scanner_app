//
//  BarcodeScannerViewModel.swift
//  BarcodeScanner
//
//  Created by RAJAT DHIMAN on 21/07/24.
//

import SwiftUI

final class BarcodeScannerViewModel : ObservableObject {
    @Published var scannedCode = ""
    @Published var alertItem : AlertItem?
    
    
}
