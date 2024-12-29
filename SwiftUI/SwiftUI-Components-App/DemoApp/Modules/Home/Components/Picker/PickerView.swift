import SwiftUI

struct PickerView: View {
    @ObservedObject var presenter: PickerPresenter
    @State private var selectedOption = 0
    let options = ["Option 1", "Option 2", "Option 3"]
    
    var body: some View {
        VStack(spacing: 10) {
            Button(action: presenter.goBack) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
            
            Spacer()
            
            Text("Select an Option")
                .font(.headline)
                .padding(10)
            
            Picker("Options", selection: $selectedOption) {
                ForEach(0..<options.count) { index in
                    Text(options[index])
                        .tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 10)
            
            Picker("Options", selection: $selectedOption) {
                ForEach(0..<options.count) { index in
                    Text(options[index])
                        .tag(index)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .padding(.vertical, 10)
            
            Picker("Options", selection: $selectedOption) {
                ForEach(0..<options.count) { index in
                    Text(options[index])
                        .tag(index)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(10)
            
            Text("Selected: \(options[selectedOption])")
                .font(.headline)
                .foregroundColor(.blue)
                .padding(10)
            
            Spacer()
        }
        .padding(10)
    }
}