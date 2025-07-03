//
//  ProfileView2.swift
//  AcademyDex
//
//  Created by Lucas Vasconcellos Côrtes on 6/30/25.
//

import SwiftUI

struct ProfileView2: View {
    var body: some View {
        VStack{
            ZStack {
                Rectangle()
                    .foregroundColor(Color(red: 28/255, green: 45/255, blue: 112/255))
                    .ignoresSafeArea(edges: .top)
                    .frame(width: .infinity)
                VStack{
                    NavigationLink(destination: HomeView()) {
                        HStack(spacing: 0) {
                            Text("Academy")
                                .font(.system(size: 48, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            Text("Dex")
                                .font(.system(size: 48, weight: .bold, design: .rounded))
                                .foregroundColor(.red)
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 50) // ajuste conforme necessário para altura do notch/status bar
                    }
                    .navigationBarBackButtonHidden(true)
                    .padding(.vertical, 8)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 40)
            Spacer()
        }
    }
}

#Preview {
    ProfileView2()
}
