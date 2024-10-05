//
//  Alert.swift
//  BarcodeScanner
//
//  Created by RAJAT DHIMAN on 21/07/24.
//

import SwiftUI

struct AlertItem  : Identifiable{
    let id = UUID()
    let title: String
    let message : String
    let dismissButton : Alert.Button
}

struct AlertContext {
    static let invailDeviceInput = AlertItem(title: "Invaild Device Input", message: "Error - 1", dismissButton: .default(Text("ok")))
    
    static let invailSacnnedValue = AlertItem(title: "Invaild Scanned value", message: "Error - 2", dismissButton: .default(Text("ok")))
}
