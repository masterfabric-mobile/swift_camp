import SwiftUI

struct SCIcon: View {
    let iconName: String
    let size: IconSize
    let color: Color
    
    var body: some View {
        Image(systemName: iconName)
            .resizable()
            .scaledToFit()
            .frame(width: size.size, height: size.size)
            .foregroundColor(color)
    }
}

#Preview {
    VStack(spacing: 20) {
        Text("Extra Small Icon")
        SCIcon(iconName: "star.fill", size: .verySmall, color: AppColors.black)
        
        Text("Slightly Small Icon")
        SCIcon(iconName: "star.fill", size: .slightlySmall, color: AppColors.black)
        
        Text("Small Icon")
        SCIcon(iconName: "star.fill", size: .small, color: AppColors.black)
        
        Text("Slightly Normal Icon")
        SCIcon(iconName: "star.fill", size: .slightlyNormal, color: AppColors.black)
        
        Text("Normal Icon")
        SCIcon(iconName: "star.fill", size: .normal, color: AppColors.black)
        
        Text("Slightly Large Icon")
        SCIcon(iconName: "star.fill", size: .slightlyLarge, color: AppColors.black)
        
        Text("Large Icon")
        SCIcon(iconName: "star.fill", size: .large, color: AppColors.black)
        
        Text("Very Large Icon")
        SCIcon(iconName: "star.fill", size: .veryLarge, color: AppColors.black)
        
        Text("Extra Large Icon")
        SCIcon(iconName: "star.fill", size: .extraLarge, color: AppColors.black)
        
        Text("High Icon")
        SCIcon(iconName: "star.fill", size: .high, color: AppColors.black)
    }
    .padding()
}
