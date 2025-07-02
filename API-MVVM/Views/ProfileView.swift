//import SwiftUI
//
//struct ProfileView: View {
//    let user: User
//    @State var index: Int
//    @StateObject var viewModel = UserViewModel()
//    @Environment(\.dismiss) var dismiss
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            ZStack(alignment: .topLeading) {
//                Color(red: 28/255, green: 45/255, blue: 112/255)
//                    .ignoresSafeArea(edges: .top)
//                
//                VStack(spacing: 8) {
//                    HStack {
//                        Button(action: {
//                            dismiss()
//                        }) {
//                            Image(systemName: "chevron.left")
//                                .foregroundColor(.white)
//                                .font(.title2)
//                                .padding(.leading)
//                        }
//                        Spacer()
//                    }
//                    
//                    HStack(spacing: 0) {
//                        Text("Academy")
//                            .font(.system(size: 40, weight: .bold, design: .rounded))
//                            .foregroundColor(.white)
//                        Text("Dex")
//                            .font(.system(size: 40, weight: .bold, design: .rounded))
//                            .foregroundColor(.red)
//                    }
//                    .padding(.bottom, 16)
//                }
//            }
//            .frame(height: 90)
//            // NAVEGAÇÃO ANTERIOR / PRÓXIMO
//            HStack {
//                HStack {
//                    Image(systemName: "chevron.left")
//
//                    if index > 0 && index - 1 < viewModel.users.count {
//                        let prevUser = viewModel.users[index - 1]
//                        Text("Nº \(prevUser.kit) \(prevUser.userName)")
//                            .font(.subheadline)
//                    } else {
//                        Text("Início")
//                            .font(.subheadline)
//                    }
//                }
//                .frame(maxWidth: .infinity, maxHeight: 40)
//                .padding()
//                .background(Color.gray.opacity(0.3))
//                HStack {
//                    if index + 1 < viewModel.users.count {
//                        let nextUser = viewModel.users[index + 1]
//                        Text("\(nextUser.userName)  Nº \(nextUser.kit)")
//                            .font(.subheadline)
//                    } else {
//                        Text("Fim")
//                            .font(.subheadline)
//                    }
//
//                    Image(systemName: "chevron.right")
//                }
//                .frame(maxWidth: .infinity, maxHeight: 40)
//                .padding()
//                .background(Color.gray.opacity(0.3))
//            }
//            ScrollView {
//                VStack(spacing: 16) {
//                    // Número
//                    Text("Nº \(user.kit)")
//                        .font(.title2)
//                        .bold()
//                    
//                    // IMAGEM
//                    Image("dog") // Troque para o nome real da imagem
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 180, height: 180)
//                        .clipShape(RoundedRectangle(cornerRadius: 16))
//                        .shadow(radius: 5)
//                    
//                    // NOME
//                    Text(user.userName.uppercased())
//                        .font(.headline)
//                        .bold()
//                        .multilineTextAlignment(.center)
//                    
//                    // TIPO
//                    HStack {
//                        atributesComponent(tela: "Perfil", cargo: user.position.namePosition.capitalized)
//                    }
//                    .frame(width: 240)
//                    
//                    // ANIVERSÁRIO (valor fictício por enquanto)
//                    aniversaryComponent(birthday: "06/11")
//                        .padding(.top, -8)
//                    
//                    // CAIXA AMARELA (descrição, habilidades, etc.)
//                    Rectangle()
//                        .fill(Color.yellow.opacity(0.2))
//                        .frame(height: 100)
//                        .overlay(
//                            Text("Área de JSON")
//                                .foregroundColor(.gray)
//                        )
//                        .padding(.top)
//                }
//                .padding()
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//        .task {
//            await viewModel.fetchData()
//        }
//    }
//}
//
//
//#Preview {
//    ProfileView(user: User(
//        idUser: "1",
//        userName: "Lucas Vasconcellos",
//        kit: 732,
//        position: Position(idPosition: "8b12014b-9463-4a4f-91e3-ed1fc5bb8ff8", namePosition: "Coder")
//    ), index: 3)
//}
import SwiftUI

struct ProfileView: View {
    @State var index: Int
    @StateObject var viewModel = UserViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var rawJSON = ""

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topLeading) {
                Color(red: 28/255, green: 45/255, blue: 112/255)
                    .ignoresSafeArea(edges: .top)

                VStack(spacing: 8) {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding(.leading)
                        }
                        Spacer()
                    }

                    HStack(spacing: 0) {
                        Text("Academy")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        Text("Dex")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundColor(.red)
                    }
                    .padding(.bottom, 16)
                }
            }
            .frame(height: 90)

            // NAVEGAÇÃO ANTERIOR / PRÓXIMO
            HStack {
                Button {
                    if index > 0 {
                        index -= 1
                    }
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        if index > 0 && index - 1 < viewModel.users.count {
                            let prevUser = viewModel.users[index - 1]
                            Text("Nº \(prevUser.kit) \(prevUser.userName)")
                                .font(.subheadline)
                        } else {
                            Text("Início")
                                .font(.subheadline)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                }

                Button {
                    if index + 1 < viewModel.users.count {
                        index += 1
                    }
                } label: {
                    HStack {
                        if index + 1 < viewModel.users.count {
                            let nextUser = viewModel.users[index + 1]
                            Text("\(nextUser.userName)  Nº \(nextUser.kit)")
                                .font(.subheadline)
                        } else {
                            Text("Fim")
                                .font(.subheadline)
                        }
                        Image(systemName: "chevron.right")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                }
            }

            // DADOS DO USUÁRIO ATUAL
            if viewModel.users.indices.contains(index) {
                let user = viewModel.users[index]

                ScrollView {
                    VStack(spacing: 16) {
                        // Número
                        Text("Nº \(user.kit)")
                            .font(.title2)
                            .bold()

                        // IMAGEM
                        Image(decidePhoto(cargo: user.position.namePosition)) // Substitua pelo nome real da imagem
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 5)

                        // NOME
                        Text(user.userName.capitalized)
                            .font(.headline)
                            .bold()
                            .multilineTextAlignment(.center)

                        // TIPO
                        HStack {
                            atributesComponent(tela: "Perfil", cargo: user.position.namePosition.capitalized)
                        }
                        .frame(width: 240)

                        // ANIVERSÁRIO (valor fictício por enquanto)
                        aniversaryComponent(birthday: "06/11")
                            .padding(.top, -8)
                        // CAIXA AMARELA
                        let json = jsonFromUser(user)
                        
                        ZStack{
                            Rectangle()
                                .fill(Color.yellow.opacity(0.2))
                                .frame(height: 100)
                                .overlay(
                                    Text("Área de JSON")
                                        .foregroundColor(.gray)
                                )
                                .padding(.top)
                        }
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
        .task {
            await viewModel.fetchData()
        }
    }
}

func decidePhoto(cargo: String) -> String {
    let cargoNe: String = cargo.capitalized
    switch cargoNe{
        case "Coder":
            return "CoderPhoto" //Azul coder
        case "Designer":
            return "DesignerPhoto" //Roxo Designer
        default:
            return "DesignerPhoto" //Azul coder
    }
}

func jsonFromUser(_ user: User) -> String {
    (try? String(data: JSONEncoder().encode(user), encoding: .utf8)) ?? ""
}

#Preview {
    ProfileView(index: 0)
}
