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
                    print("[WatchUnitSelectionView] Botão clicado: \(unit)")
                    onSelect(unit)
                }) {
                    Text("°" + unit.uppercased())
                        .font(.title2)
                        .foregroundColor(Color.watchPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(
                            unit.lowercased() == selectedUnit.lowercased() ? Color.watchPrimary.opacity(0.15) : Color.clear
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