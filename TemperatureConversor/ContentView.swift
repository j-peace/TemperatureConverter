import SwiftUI

struct ContentView: View {
    private let temperatureInCelsius: Double = 17.0
    @State private var isTextHidden = false

    var body: some View {
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 161/255, green: 180/255, blue: 178/255), // #a1b4b2
                    Color(red: 216/255, green: 236/255, blue: 234/255)  // #d8ecea
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack {
                Text("Temperature Conversor")
                    .font(.custom("GillSans-SemiBold", size: 27))
                    .foregroundColor(Color(red: 40/255, green: 47/255, blue: 67/255))

                (
                    Text("Convert your temperature in ") +
                    Text("real time")
                        .font(.custom("GillSans-Bold", size: 20))
                        .foregroundColor(Color(red: 77/255, green: 143/255, blue: 248/255)) +
                    Text("!")
                )
                .font(.custom("GillSans-SemiBold", size: 20))
                .foregroundColor(Color(red: 40/255, green: 47/255, blue: 67/255))
                .padding(.bottom, 20)
                
                ZStack {
                    if !isTextHidden {
                        Color(red: 42/255, green: 42/255, blue: 44/255)
                            .frame(width: 202, height: 232)
                            .padding(.trailing, 10)
                    }else {
                        Color(red: 117/255, green: 118/255, blue: 135/255)
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
                                .foregroundColor(.white)

                            HStack (spacing: 10) {
                                VStack {
                                    Image(systemName: "chevron.down")
                                        .resizable()
                                        .frame(width: 15, height: 8)
                                    Image(systemName: "chevron.down")
                                        .resizable()
                                        .frame(width: 15, height: 8)
                                        .padding(.top, -7)
                                }
                                Text("swipe to change")
                                    .font(.custom("GillSans-SemiBold", size: 17))
                                    .foregroundColor(Color(red: 40/255, green: 47/255, blue: 67/255))
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
                            }) {
                                Text("Preview")
                                    .font(.custom("GillSans-SemiBold", size: 20))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color(red: 77/255, green: 143/255, blue: 248/255),
                                                Color(red: 140/255, green: 140/255, blue: 255/255)
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
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(red: 77/255, green: 143/255, blue: 248/255))
                                .cornerRadius(30)
                        }
                    }
                }.frame(height: 80)

            }
        }
    }
}

#Preview {
    ContentView()
}
