//
//  CreateUserView.swift
//  API-MVVM
//
//  Created by Filipi Romão on 02/07/25.
//

import SwiftUI

struct CreateUserView: View {
    @ObservedObject var viewModel: UserViewModel
    @State private var birthday = Date()

    var body: some View {
        VStack{
            Text("Criar usuário")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 20){
                VStack(alignment:.leading){
                    Text("Nome")
                        .font(.headline)
                        
                    TextField("Insira o nome", text: $viewModel.newUserName)
                        .padding()
                       
                        .frame(height: 40)
                      //  .background(Color.colorBlue)
                       
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.colorBlue, lineWidth: 2)
                        )
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 4)
                }.padding()
                    
                VStack(alignment: .leading){
                    Text("Kit")
                        .font(.headline)
                    TextField("Insira o Kit", text: $viewModel.newKit)
                        .padding()
                        .frame(height: 40)
                   
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.colorBlue, lineWidth: 2)
                        )
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 4)
                }.padding()
                VStack(alignment: .leading) {
                    Text("Cargo")
                        .font(.headline)

                    SelectPositionComponent(
                        options: viewModel.positionOptions,
                        element: $viewModel.newPosition,
                        
                    )
                }
                .padding()

                HStack() {
                    Text("Data de Nascimento")
                        .font(.headline)
                    
                    DatePicker(
                        "Selecione a data",
                        selection: $viewModel.newBirthday,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .frame(height: 24)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 0)
                    )
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 4)
                }
                .padding()

            }
            VStack{
                Button("Criar") {
                    Task {
                        await viewModel.createUser()
                        
                        if viewModel.userCreated {
                            viewModel.showAlert = true
                        }
                    }
                }
                
                .frame(maxWidth: 200, maxHeight: 40)
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.top,40)
        }
        .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Usuário criado com sucesso"),
                    message: Text("Agora roda um CBL aí")
                )
            }
    }
        
}
#Preview {
    CreateUserView(viewModel: UserViewModel())
}
