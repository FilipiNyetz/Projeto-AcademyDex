//
//  perfilHeaderComponent.swift
//  API-MVVM
//
//  Created by Filipi Romão on 03/07/25.
//
//Color(red: 28/255, green: 45/255, blue: 112/255)
import SwiftUI

struct AcademyDexHeaderProfile: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack{
            VStack{
                HStack{
                    Button(action: {
                        print("vai voltar")
                        dismiss()
                    },label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 32))
                        
                    })
                    Spacer()
                }
                .padding()
                .padding(.top, 60)
                .padding(.bottom, -40)
                HStack(spacing: 0) {
                    Text("Academy")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    Text("Dex")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.red)
                }
                
            }
        }
        .edgesIgnoringSafeArea(.all)
        .frame(width: .infinity, height: 170)
        .background(Color(red: 28/255, green: 45/255, blue: 112/255))
        
    }
}// end body

#Preview{
    AcademyDexHeaderProfile()
}
