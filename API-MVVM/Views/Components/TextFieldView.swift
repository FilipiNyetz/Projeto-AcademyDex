//
//  TextFieldView.swift
//  API-MVVM
//
//  Created by Filipi Romão on 02/07/25.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text("Ex: 150")
                    .foregroundColor(.black)
                    .padding(.leading, 20)
            }
            
            TextField("", text: $text)
                .frame(height: 32)
                .background(Color.colorBlue)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 4)
        }
    }
}

//#Preview {
//    TextFieldView()
//}
