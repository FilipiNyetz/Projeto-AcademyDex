import SwiftUI

struct ProfileView: View {
    @State var index: Int
    let lista: [User]
    @Environment(\.dismiss) var dismiss
    @State private var rawJSON = ""
    @State private var isEditable: Bool = true
    
    @ObservedObject var viewModel: UserViewModel
    
    @State var userDisplayed: User = User(
        idUser: "",
        userName: "",
        kit: 0,
        position: Position(idPosition: "", namePosition: ""),
        birthday: ""
    )

        
    var body: some View {
        VStack(spacing: 0) {
            // TOPO
            VStack {
                AcademyDexHeaderProfile()
                    .padding(.top, 3)
            }
            .frame(maxWidth: .infinity)
            .edgesIgnoringSafeArea(.top)
            
            // NAVEGAÇÃO
            HStack {
                Button {
                    if index > 0 {
                        index -= 1
                    }
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        if index > 0 && index - 1 < lista.count {
                            let prevUser = lista[index - 1]
                            Text("\(prevUser.kit) - \(prevUser.userName)")
                                .font(.body)
                        } else {
                            Text("Início")
                                .font(.body)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                }
                
                Button {
                    if index + 1 < lista.count {
                        index += 1
                    }
                } label: {
                    HStack {
                        if index + 1 < lista.count {
                            let nextUser = lista[index + 1]
                            Text("\(nextUser.userName) - \(nextUser.kit)")
                                .font(.body)
                        } else {
                            Text("Fim")
                                .font(.body)
                        }
                        Image(systemName: "chevron.right")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                }
            }
            .padding(.top, -54)
            
            // CONTEÚDO PRINCIPAL
            if lista.indices.contains(index) {
                let user = lista[index]
                    VStack(spacing: 12) {
                        Text("Nº \(user.kit)")
                            .font(.title2)
                            .bold()
                            .padding(.top, 12)
                        
                        Image(decidePhoto(cargo: user.position.namePosition))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 5)
                        
                        Text(user.userName.capitalized)
                            .font(.title)
                            .bold()
                            .multilineTextAlignment(.center)
                        
                        HStack {
                            atributesComponent(tela: "Perfil", cargo: user.position.namePosition.capitalized)
                        }
                        .frame(width: 240)
                        Button(action: {print(user.birthday)},label:{
                            aniversaryComponent(birthday: user.birthday)
                                .padding(.top, -8)
                        }
                        )
                        
                        HStack{
                            TextEditor(text: $rawJSON)
                                .frame(width: 360, height: 100)
                                .border(Color.gray)
                                .disabled(isEditable)
                        }.frame(maxWidth: .infinity)
                            .frame(height: 124)
                        .background(Color.yellow.opacity(0.2))
                        
                        HStack {
                            Button(action:{
                                print("Vai editar")
                                isEditable.toggle()
                            },label:{
                                Text("Editar")
                            })
                            .frame(width: 160, height: 56)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            
                            Button("Salvar") {
                                Task {
                                    isEditable.toggle()
                                    if let updatedUser = viewModel.decodeUser(from: rawJSON) {
                                        await viewModel.editUser(from: updatedUser)

                                        if viewModel.userUpdated {
                                            print("Editou com sucesso")
                                        }
                                    } else {
                                        print("JSON inválido")
                                    }
                                }
                            }.frame(width: 160, height: 56)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)

                        }
                    }
                    .padding()
                    .padding(.top, -12)
            } else {
                Spacer()
                ProgressView("Carregando...")
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            userDisplayed = User(
                idUser: viewModel.users[index].idUser,
                userName: viewModel.users[index].userName,
                kit: viewModel.users[index].kit,
                position: viewModel.users[index].position,
                birthday: viewModel.users[index].birthday)
            rawJSON = viewModel.encodeJSON(from: userDisplayed)
        }
        .onChange(of: index){
            userDisplayed = User(
                idUser: viewModel.users[index].idUser,
                userName: viewModel.users[index].userName,
                kit: viewModel.users[index].kit,
                position: viewModel.users[index].position,
                birthday: viewModel.users[index].birthday)
            rawJSON = viewModel.encodeJSON(from: userDisplayed)
        }
    }
        
}

func decidePhoto(cargo: String) -> String {
    switch cargo.capitalized {
    case "Coder":
        return "CoderPhoto"
    case "Designer":
        return "DesignerPhoto"
    case "Mentor":
        return "MentorPhoto"
    case "Mentor Jr":
        return "MentorJrPhoto"
    case "Suporte":
        return "SuportPhoto"
    default:
        return "CoderPhoto"
    }
}

//func jsonFromUser() -> String {
//    let jsonData = try JSONEncoder().encode()
//}

//#Preview {
//    ProfileView(index: 0, lista: [
//        User(
//            idUser: "3",
//            userName: "Lucas Vasconcellos",
//            kit: 732,
//            position: Position(idPosition: "skrrrrr", namePosition: "Coder"),
//            birthday: "06/11"
//        )
//    ])
//}

