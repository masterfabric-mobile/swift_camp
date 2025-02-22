import SwiftUI

struct SCCheckbox: View {
    @Binding var state: CheckboxState
    var type: CheckboxType = .square
    var checkboxColor: Color = AppColors.black
    
    var body: some View {
        Button(action: {
            toggleState()
        }) {
            ZStack {
                if type == .square {
                    RoundedRectangle(cornerRadius: UISizerHelper.Radius.low)
                        .fill(state == .checked ? checkboxColor : .clear) // Fills when checked
                        .frame(width: 32, height: 32)
                        .overlay(
                            RoundedRectangle(cornerRadius: UISizerHelper.Radius.low)
                                .stroke(checkboxColor, lineWidth: UISizerHelper.Border.thin)
                        )
                } else {
                    Circle()
                        .fill(state == .checked ? checkboxColor : .clear) // Fills when checked
                        .frame(width: 32, height: 32)
                        .overlay(
                            Circle()
                                .stroke(checkboxColor, lineWidth: UISizerHelper.Border.thin)
                        )
                }
                
                // Checkmark icon
                if state == .checked {
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: UISizerHelper.IconSize.slightlyNormal, height: UISizerHelper.IconSize.slightlyNormal)
                        .foregroundColor(.white) // White tick
                }
            }
        }
        .padding()
    }
    
    private func toggleState() {
        state = state == .checked ? .unchecked : .checked
    }
}

// Preview
struct SCCheckbox_Previews: PreviewProvider {
    struct TestView: View {
        @State private var squareCheckboxState: CheckboxState = .unchecked
        @State private var circleCheckboxState: CheckboxState = .unchecked
        
        var body: some View {
            VStack(spacing: 20) {
                SCCheckbox(state: $squareCheckboxState, type: .square, checkboxColor: AppColors.black)
                SCCheckbox(state: $circleCheckboxState, type: .circle, checkboxColor: AppColors.black)
            }
        }
    }
    
    static var previews: some View {
        TestView()
    }
}
