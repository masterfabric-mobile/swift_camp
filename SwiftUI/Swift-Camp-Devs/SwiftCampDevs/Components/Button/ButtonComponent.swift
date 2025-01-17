import SwiftUI

struct AppButton: View {

    var type: ButtonType

    var size: ButtonSize

    var text: String

    var action: () -> Void

    var isEnabled: Bool = true

    var body: some View {
        
        Button(action: isEnabled ? action : {}) {

            switch type {
                
            case .icon:

                Image(systemName: text)
                    .resizable()
                    .frame(width: type.iconSize, height: type.iconSize)
                    .foregroundColor(isEnabled ? type.textColor : AppColors.darkGray)
                    .padding(size.padding)
                    .background(isEnabled ? AppColors.powderBlue : AppColors.lightGray)
                    .cornerRadius(8)

            case .normal:

                Text(text)
                    .font(.system(size: size.fontSize))
                    .foregroundColor(isEnabled ? type.textColor : AppColors.darkGray)
                    .padding(size.padding)
                    .background(isEnabled ? type.backgroundColor : AppColors.lightGray)
                    .cornerRadius(8)

            case .text:

                Text(text)
                    .font(.system(size: size.fontSize))
                    .foregroundColor(isEnabled ? type.textColor : AppColors.lightGray)
                    .padding(size.padding)
                    .background(isEnabled ? type.backgroundColor : Color.clear)
                    .cornerRadius(8)
            }

        }

        .disabled(!isEnabled)

    }

}

#Preview {

    VStack(spacing: 20) {
        
        Text("Normal Button | Enabled")
        AppButton(type: .normal, size: .small, text: "Next", action: {}, isEnabled: true)
        Text("Text Button | Disabled")
        AppButton(type: .text, size: .medium, text: "Add", action: {}, isEnabled: true)
        Text("Icon Button | Disabled")
        AppButton(type: .icon, size: .medium, text: "star.fill", action: {}, isEnabled: false)
        Text("Icon Button | Enabled")
        AppButton(type: .icon, size: .large, text: "heart.fill", action: {}, isEnabled: true)

    }

    .padding()

}