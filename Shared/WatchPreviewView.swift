import SwiftUI

struct WatchPreviewView: View {
    @ObservedObject var viewModel: ContentViewModel
    @Binding var showWatchUnitSheet: Bool

    var body: some View {
        ZStack {
            if showWatchUnitSheet {
                VStack {
                    if !viewModel.units.isEmpty {
                        WatchUnitSelectionView(
                            units: viewModel.units,
                            selectedUnit: viewModel.temperatureUnit.lowercased(),
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
}
