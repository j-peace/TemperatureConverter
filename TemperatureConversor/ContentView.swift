import SwiftUI

struct ContentView: View {
    private let temperatureInCelsius: Double = 17.0
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

                ZStack {
                    Color(red: 42/255, green: 42/255, blue: 44/255)
                        .frame(width: 202, height: 232)
                        .padding(.trailing, 10)
                    
                    // Hide when press button
                    Image("mockup-apple-watch")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 500, height: 500)
                    
                    // Shiw when press button
                    Text("\(temperatureInCelsius, specifier: "%.0f") °C")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
