import SwiftUI

struct ProfileView: View {
    @State var index: Int
    let lista: [User]
    @Environment(\.dismiss) var dismiss
    @State private var rawJSON = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // TOPO
            VStack {
                AcademyDexHeaderProfile()
                    .padding(.top, 3)
            }
            .frame(maxWidth: .infinity)
            .edgesIgnoringSafeArea(.top)
            .padding(.bottom, -62)
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
            
            // CONTEÚDO PRINCIPAL
            if lista.indices.contains(index) {
                let user = lista[index]
                
                ScrollView {
                    VStack(spacing: 16) {
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
                        JSONBoxView(user: user)
                    }
                    .padding()
                }
            } else {
                Spacer()
                ProgressView("Carregando...")
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

func decidePhoto(cargo: String) -> String {
    switch cargo.capitalized {
    case "Coder":
        return "CoderPhoto"
    case "Designer":
        return "DesignerPhoto"
    default: return
        "DesignerPhoto"
    }
}

func jsonFromUser(_ user: User) -> String {
    (try? String(data: JSONEncoder().encode(user), encoding: .utf8)) ?? ""
}

#Preview {
    ProfileView(index: 0, lista: [
        User(
            idUser: "3",
            userName: "Lucas Vasconcellos",
            kit: 732,
            position: Position(idPosition: "skrrrrr", namePosition: "Coder"),
            birthday: "06/11"
        )
    ])
}
