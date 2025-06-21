import SwiftUI

struct ContentView: View {
    private let temperatureInCelsius: Double = 17.0

    var body: some View {
        Text("Convert your temperature in real time")
        ZStack {
            Image("mockup-apple-watch")
                .resizable()
                .scaledToFit()
                .frame(width: 500, height: 500)
            
            Text("\(temperatureInCelsius, specifier: "%.0f") °C")
                .font(.largeTitle)
                .foregroundColor(.black)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
