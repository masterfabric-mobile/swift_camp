import SwiftUI

struct SCToggle: View {
    @Binding var state: Bool
    
    var toggleColor: Color
    
    init(state: Binding<Bool>, toggleColor: Color = .black) {
        _state = state
        self.toggleColor = toggleColor
    }
    
    var body: some View {
        Toggle(isOn: $state) {
            EmptyView()
        }
        .toggleStyle(SwitchToggleStyle(tint: toggleColor))
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(12)
        .onChange(of: state) { _ in
        }
    }
}
