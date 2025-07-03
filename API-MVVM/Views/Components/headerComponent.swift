//
//  headerComponent.swift
//  API-MVVM
//
//  Created by Filipi Romão on 03/07/25.
//

import SwiftUI

struct AcademyDexHeader: View {
    @State private var searchText = ""
    @StateObject var viewModel = UserViewModel()
  //  @State private var showFiltros = false
    @Binding var showFilter: Bool//para o botao de filtragem


    var body: some View {
        ZStack {
            
                //Fundo cinza atrás de tudo
                Color(red: 170/255, green: 173/255, blue: 185/255)
                    .ignoresSafeArea()
                    .frame(height: 155)
                    .padding(.top, 55)
               
                //barrinha cinza mais escuro
            Color(.gray)
                    .ignoresSafeArea()
                    .frame(height: 13)
                    .padding(.top, 220)
            
            VStack(spacing: 0) {
                // Header azul com texto
                ZStack {
                         Color(red: 28/255, green: 45/255, blue: 112/255)
                        .padding(.bottom, 69)
                        .frame(height: 216)
                    HStack(spacing: 0) {
                        Text("Academy")
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        Text("Dex")
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundColor(.red)
                    }// end Hstack
                    
                    //Pesquisar
                    HStack(spacing: 4) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)

                        TextField("Buscar...", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .autocorrectionDisabled(true)

                        // Botão de buscar manualmente
                        Button {
                            Task {
                               
                            }
                        } label: {
                            Image(systemName: "arrow.forward.circle.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }

                        // Botão de filtro
                        Button {
                            showFilter = true
                        } label: {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .padding(.top, 150)

                    
                }// end Zstack 2
               // .frame(height: 90)
            }// end VStack
        }// end ZSTACK
    }// end body
}//

#Preview{
    AcademyDexHeader(showFilter: .constant(true))
}
