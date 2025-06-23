import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @State var showWatchUnitSheet = false

    var body: some View {
        ZStack {
            Color.watchTertiary
                .ignoresSafeArea()
            WatchPreviewView(viewModel: viewModel, showWatchUnitSheet: $showWatchUnitSheet)
        }
    }
}
