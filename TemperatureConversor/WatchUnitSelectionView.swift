import SwiftUI

struct WatchUnitSelectionView: View {
    let units: [String]
    let selectedUnit: String
    let onSelect: (String) -> Void
    let onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(units, id: \.self) { unit in
                Button(action: {
                    onSelect(unit)
                }) {
                    Text("°" + unit)
                        .font(.title2)
                        .foregroundColor(unit == selectedUnit ? Color.watchPrimary : Color.watchPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(
                            unit == selectedUnit ? Color.watchPrimary.opacity(0.15) : Color.clear
                        )
                        .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
            }
            Spacer()
        }
        .padding()
    }
} 