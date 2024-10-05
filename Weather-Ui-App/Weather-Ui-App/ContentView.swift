//
//  ContentView.swift
//  Weather-Ui-App
//
//  Created by RAJAT DHIMAN on 29/06/24.
//


//H stack is like row
//V stack is like column
//Z stack is like stack or over lap of widgets


import SwiftUI

struct ContentView: View {
    @State private var isNight = false ;
    
    var body: some View {
        
        ZStack(
            content: {
                //Background color
                BackgroundView(
                    isNight: isNight
                )
                
                VStack(
                    content : {

                                    //city name and state name
                    CityTextView(cityName: "Kaithal", stateName:"HR")
                        
                                   // image and temperature
                        
                    ImageAndTemperatur(
                                            imageString: isNight ?"moon.stars.fill" : "cloud.sun.fill", tempearture: 27)
                        
                    HStack(
                                            spacing : 20 ,
                        content: {
                         
                                            DayWeatherView(dayName: "TUE", imageName: "cloud.sun.fill", temperature: 35)
                                            DayWeatherView(dayName: "WED", imageName: "sun.max.fill", temperature: 52)
                                            DayWeatherView(dayName: "THU", imageName: "snow", temperature: 25)
                                            DayWeatherView(dayName: "FRI", imageName: "wind", temperature: 45)
                                            DayWeatherView(dayName: "SAT", imageName: "snow", temperature: 15)
                        
                        })
                        
                        Spacer()
                                    //Button
                        Button{
                                            //action part
                                        isNight.toggle()
                                }label: {
                        
                        CustomButtonView(lableName: "Change Day Time" , textColor: .blue , bgColor: .white)
                        
                            }
                        Spacer()
                    }
                )

            }
        )
        
    }
}

#Preview {
    ContentView()
}

struct DayWeatherView: View {
    var dayName: String
    var imageName :  String
    var temperature : Int
    var body: some View {
        VStack(
            content: {
            Text(dayName)
                .font(.system(size: 16 , weight: .medium))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40 , height: 40)
            Text("\(temperature)°")
                .font(.system(size: 28 , weight: .medium))
                .foregroundColor(.white)
            
        })
    }
}

struct BackgroundView: View {
    var isNight : Bool
    
//    var topColor : Color
//    var bottomColor : Color
//topColor: isNight ? .black :  .blue,
//bottomColor: isNight ? .gray :  Color("lightBlueColor")
    
    var body: some View {
        
//        LinearGradient(gradient: Gradient(
//            colors: [isNight ? .black :  .blue,
//                     isNight ? .gray :  Color("lightBlueColor")]),
//                       startPoint: .topLeading,
//                       endPoint: .bottomTrailing)
//        
//        //this is for to take color over safe area also
//        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
        ContainerRelativeShape()
            .fill(isNight ? Color.black.gradient : Color.blue.gradient)
            .ignoresSafeArea()
    }
}

struct CityTextView: View {
    var cityName : String
    var stateName : String
    var body: some View{
        
        Text("\(cityName), \(stateName)")
            .font(.system(size: 30 , weight: .medium , design: .rounded))
            .foregroundColor(.white)
            .padding()
    }
}


struct ImageAndTemperatur: View {
    var imageString :String
    var tempearture : Int
    var body: some View {
        VStack(
            spacing : 10 ,
            content: {
                Image(systemName: imageString)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180 , height: 180)
                Text("\(tempearture)°")
                    .font(.system(size: 72 , weight: .medium))
                    .foregroundColor(.white)
            }).padding(.bottom , 50)
    }
}

