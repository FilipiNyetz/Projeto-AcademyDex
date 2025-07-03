//
//  perfilHeaderComponent.swift
//  API-MVVM
//
//  Created by Filipi Romão on 03/07/25.
//

import SwiftUI

struct AcademyDexHeaderProfile: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ZStack {
                    // Fundo azul
                    Color(red: 28/255, green: 45/255, blue: 112/255)
                        .ignoresSafeArea(edges: .top) // ← Isso gruda no topo
                        .frame(height: 150)
                        .frame(width: 500)
                    // Texto AcademyDex
                    HStack(spacing: 0) {
                        Text("Academy")
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        Text("Dex")
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundColor(.red)
                    }
                    .padding(.top, 50)
                }
            }
        } // end ZStack
    }// end body
}// end vie
