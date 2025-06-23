import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var showWatchUnitSheet = false
    
    var body: some View {
        
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
                    if !viewModel.isTextHidden {
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
                    
                    if viewModel.isTextHidden {
                        ZStack {
                            if showWatchUnitSheet {
                                VStack {
                                    if !viewModel.units.isEmpty {
                                        WatchUnitSelectionView(
                                            units: viewModel.units,
                                            selectedUnit: viewModel.temperatureUnit,
                                            onSelect: { unit in
                                                viewModel.selectUnit(unit)
                                                showWatchUnitSheet = false
                                            },
                                            onClose: {
                                                showWatchUnitSheet = false
                                            }
                                        )
                                        .frame(width: 202, height: 232)
                                    }
                                }.padding(.top, 17)
                            } else {
                                VStack {
                                    Image("temperaturas")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .padding()
                                    if let temp = viewModel.currentConvertedTemperature {
                                        Text("\(temp, specifier: "%.0f") °\(viewModel.temperatureUnitSymbol)")
                                            .font(.largeTitle)
                                            .foregroundColor(.watchPrimary)
                                    } else {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: .watchPrimary))
                                    }
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
                        }
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture(minimumDistance: 30, coordinateSpace: .local)
                                .onEnded { value in
                                    if value.translation.height < 0 {
                                        showWatchUnitSheet = true
                                    }
                                }
                        )
                    }
                    
                    if !viewModel.isTextHidden {
                        VStack {
                            
                            Image("temperaturas")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .padding()

                            Button(action: {
                                viewModel.togglePreview()
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
                    if viewModel.isTextHidden {
                        Button(action: {
                            viewModel.togglePreview()
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
        .onAppear {
            viewModel.onAppear()
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
