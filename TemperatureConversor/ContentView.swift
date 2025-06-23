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
                        WatchPreviewView(viewModel: viewModel, showWatchUnitSheet: $showWatchUnitSheet)
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
