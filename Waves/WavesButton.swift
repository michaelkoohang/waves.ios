
import SwiftUI

struct WavesButton: View {
    var text: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            HStack(alignment: .center, spacing: 0) {
                LinearGradient(gradient: Gradient(colors: [color]), startPoint: .leading, endPoint: .trailing)
                    .mask(
                        Text(text)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .frame(maxWidth: .infinity, alignment: .center)
                    )
            }
            .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous)
                    .fill(Color.white)
            )
        })
    }
}

struct WavesButton_Previews: PreviewProvider {
    static var previews: some View {
        WavesButton(text: "Test", color: Color(.systemPink), action: {
            print("HELLo")
        }).previewLayout(.sizeThatFits)
    }
}
