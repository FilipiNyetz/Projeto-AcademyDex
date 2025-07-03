//
//  JSONBoxView.swift
//  API-MVVM
//
//  Created by Lucas Vasconcellos Côrtes on 7/3/25.
//
import SwiftUI

struct JSONBoxView: View {
    let user: User

    var body: some View {
        let json = jsonFromUser(user)

        ScrollView(.vertical) {
            Text(json)
                .font(.system(.caption, design: .monospaced))
                .padding()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 120)
        .background(Color.yellow.opacity(0.2))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.yellow.opacity(0.4), lineWidth: 1)
        )
        .padding(.top)
    }
}
