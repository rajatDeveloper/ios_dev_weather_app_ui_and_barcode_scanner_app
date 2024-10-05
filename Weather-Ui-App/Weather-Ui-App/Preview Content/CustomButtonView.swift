//
//  CustomButtonView.swift
//  Weather-Ui-App
//
//  Created by RAJAT DHIMAN on 07/07/24.
//

import SwiftUI


struct CustomButtonView : View {
    var lableName : String
    var textColor : Color
    var bgColor : Color
    var body: some View{
        Text(lableName)
            .frame(width : 250 , height: 50)
            .font(.system(size: 18 , weight: .medium , design: .rounded))
            .foregroundColor(textColor)
            .background(bgColor)
            .cornerRadius(10)
    }
}
