//
//  BarcodeScannerView.swift
//  BarcodeScanner
//
//  Created by RAJAT DHIMAN on 21/07/24.
//

import SwiftUI




struct BarcodeScannerView: View {
   
    @StateObject var viewModel = BarcodeScannerViewModel()
    
    
    var body: some View {
        NavigationView{
            VStack{
                
                Spacer()
                
//                Text("").frame(maxWidth: .infinity  , maxHeight: 200).foregroundColor(Color.gray).background(Color.gray)
//                
                ScannerView(scannedCode: $viewModel.scannedCode ,
                            alertItem: $viewModel.alertItem)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/  , maxHeight: 300)
                
                Spacer()
                
                Label("Sacnned Barcode" , systemImage: "barcode.viewfinder").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                Text(viewModel.scannedCode.isEmpty ? "Not Scanned yet!": viewModel.scannedCode)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(viewModel.scannedCode.isEmpty ? Color.red :  Color.green)
                    .padding()
                Spacer()
            }.navigationTitle("Barcode Scanner")
                .alert(item: $viewModel.alertItem ){
                    alertItem in Alert(
                        title:Text( alertItem.title) ,
                        message: Text(alertItem.message) ,
                        dismissButton: alertItem.dismissButton)
                }
        }
    }
}

#Preview {
    BarcodeScannerView(
        
    )
}
