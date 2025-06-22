import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    private let temperatureInCelsius: Double = 17.0
    @State private var isTextHidden = false

    var body: some View {
        
        VStack {
            if let location = locationManager.lastKnownLocation {
                Text("Latitude: \(location.latitude)")
                Text("Longitude: \(location.longitude)")
            } else {
                Text("Getting location...")
            }
        }
        
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [
                    .backgroundDarkBlue,
                    .watchSecondary
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack {
                Text("Temperature Conversor")
                    .font(.custom("GillSans-SemiBold", size: 27))
                    .foregroundColor(.watchTertiary)

                (
                    Text("Convert your temperature in ") +
                    Text("real time")
                        .font(.custom("GillSans-Bold", size: 20))
                        .foregroundColor(.highlightYellow) +
                    Text("!")
                )
                .font(.custom("GillSans-SemiBold", size: 20))
                .foregroundColor(.watchTertiary)
                .padding(.bottom, 20)
                
                ZStack {
                    if !isTextHidden {
                        Color.previewCardBackground
                            .frame(width: 202, height: 232)
                            .padding(.trailing, 10)
                    }else {
                        Color.watchTertiary
                            .frame(width: 202, height: 232)
                            .padding(.trailing, 10)
                    }

                    Image("mockup-apple-watch")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 500, height: 500)
                    
                    if isTextHidden {
                        
                        VStack {
                            
                            Image("temperaturas")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .padding()
                            
                            Text("\(temperatureInCelsius, specifier: "%.0f") °C")
                                .font(.largeTitle)
                                .foregroundColor(.watchPrimary)

                            HStack (spacing: 10) {
                                VStack {
                                    Image(systemName: "chevron.down")
                                        .resizable()
                                        .frame(width: 15, height: 8)
                                        .foregroundColor(.watchPrimary)
                                    Image(systemName: "chevron.down")
                                        .resizable()
                                        .frame(width: 15, height: 8)
                                        .padding(.top, -7)
                                        .foregroundColor(.watchPrimary)
                                }
                                Text("swipe to change")
                                    .font(.custom("GillSans-SemiBold", size: 17))
                                    .foregroundColor(.watchPrimary)
                            }
                            .padding(.top, 18)
                        }
                    }
                    
                    if !isTextHidden {
                        VStack {
                            
                            Image("temperaturas")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .padding()

                            Button(action: {
                                isTextHidden.toggle()
                                locationManager.checkLocationAuthorization()
                            }) {
                                Text("Preview")
                                    .font(.custom("GillSans-SemiBold", size: 20))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                .watchPrimary,
                                                .watchSecondary
                                            ]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .cornerRadius(30)
                            }
                        }
                        
                    }
                }.frame(height: 520)
                VStack {
                    if isTextHidden {
                        Button(action: {
                            isTextHidden.toggle()
                        }) {
                            Text("Finish preview")
                                .font(.custom("GillSans-SemiBold", size: 20))
                                .foregroundColor(.watchSecondary)
                                .padding()
                                .background(Color.highlightYellow)
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.watchSecondary, lineWidth: 2)
                                )
                        }
                    } else {
                        Text("Tap Preview to see the watch")
                            .font(.custom("GillSans-SemiBold", size: 18))
                            .foregroundColor(.watchTertiary)
                            .padding(.top, 16)
                    }
                }.frame(height: 80)

            }
        }
    }
}

#Preview {
    ContentView()
}

// MARK: - Color Extension

extension Color {
    static let watchPrimary = Color(red: 0/255, green: 155/255, blue: 255/255)
    static let watchSecondary = Color(red: 0/255, green: 78/255, blue: 182/255)
    static let watchTertiary = Color(red: 230/255, green: 244/255, blue: 241/255)

    static let previewBackgroundTop = Color(red: 161/255, green: 180/255, blue: 178/255)
    static let previewCardBackground = Color(red: 42/255, green: 42/255, blue: 44/255)
    static let highlightYellow = Color(red: 243/255, green: 213/255, blue: 91/255)
    static let backgroundDarkBlue = Color(red: 26/255, green: 38/255, blue: 54/255)
}
