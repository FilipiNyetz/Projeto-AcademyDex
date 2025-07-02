////
////  AtributesView.swift
////  AcademyDex
////
////  Created by Lucas Vasconcellos Côrtes on 6/30/25.
////
import SwiftUI

struct aniversaryComponent: View {
    let birthday: String
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(hex: 0x1C2D70))
                .cornerRadius(20)
            
            HStack{
                Text("Aniversário")
                Spacer()
                Text("\(birthday)")
            }
            .padding(.horizontal)
            .font(.body)
            .foregroundStyle(Color.white)
            .fontWeight(.heavy)
        }
        .frame(width: 260, height: 40)
    }
}

#Preview {
    aniversaryComponent(birthday: "06/11")
}
