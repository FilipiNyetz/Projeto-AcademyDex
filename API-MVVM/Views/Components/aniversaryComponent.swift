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
                Text(formatBirthday(birthday))
            }
            .padding(.horizontal)
            .font(.body)
            .foregroundStyle(Color.white)
            .fontWeight(.heavy)
        }
        .frame(width: 260, height: 40)
    }
}

func formatBirthday(_ isoDate: String) -> String {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime]

    if let date = formatter.date(from: isoDate) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM"
        return outputFormatter.string(from: date)
    } else {
        return "Data inválida"
    }
}

#Preview {
    aniversaryComponent(birthday: "06/11")
}
