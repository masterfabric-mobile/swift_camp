import SwiftUI

struct PickerView: View {
    @ObservedObject var presenter: PickerPresenter
    @State private var selectedOption = 0
    let options = ["Option 1", "Option 2", "Option 3"]
    
    var body: some View {
        VStack(spacing: 20) {
            // Back button with consistent style
            Button(action: presenter.goBack) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Text("Select an Option")
                .font(.headline)
                .padding()
            
            // Segmented Picker
            Picker("Options", selection: $selectedOption) {
                ForEach(0..<options.count) { index in
                    Text(options[index])
                        .tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // Wheel Picker
            Picker("Options", selection: $selectedOption) {
                ForEach(0..<options.count) { index in
                    Text(options[index])
                        .tag(index)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .padding()
            
            // Menu Picker
            Picker("Options", selection: $selectedOption) {
                ForEach(0..<options.count) { index in
                    Text(options[index])
                        .tag(index)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
            Text("Selected: \(options[selectedOption])")
                .font(.headline)
                .foregroundColor(.blue)
                .padding()
            
            Spacer()
        }
        .padding()
    }
}
