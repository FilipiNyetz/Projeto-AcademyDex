import SwiftUI

struct SelectPositionComponent: View {
    var options: [String]
    @Binding var element: String

    var body: some View {
        VStack(alignment: .leading) {
            Menu {
                ForEach(options, id: \.self) { item in
                    Button(action: {
                        element = item
                        
                    }) {
                        Text(item)
                    }
                }
            } label: {
                HStack {
                    Text(element.isEmpty ? "Selecione uma opção" : element)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.up.chevron.down")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .frame(width: 360, height: 40)
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            }
        }
    }
}
