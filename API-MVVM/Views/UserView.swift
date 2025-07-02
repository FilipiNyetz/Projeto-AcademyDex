//import SwiftUI
//
//struct UserView: View {
//    @StateObject var viewModel = UserViewModel()
//
//    var gridRows: [GridItem] {
//        [
//            GridItem(.flexible()),
//            GridItem(.flexible())
//        ]
//    }
//
//    var body: some View {
//
//        NavigationView {
//            if viewModel.selectedIndex != nil {
//                VStack {
//
//                    Text("Ja ta no foco")
//                    VStack(alignment: .leading, spacing: 4) {
//
//                        let user = viewModel.users[viewModel.selectedIndex ?? 0]
//                        Button(action: {
//                            viewModel.previousUser()
//                        },label: {
//                            Text("Anterior")
//                        })
//                        Button(action: {
//                            viewModel.nextUser()
//                        },label: {
//                            Text("Proximo")
//                        })
//                        Text(user.userName)
//                            .font(.headline)
//                        Text("\(user.kit)")
//
//                        Text("Cargo: \(user.position.namePosition)")
//                    }
//                    Button(action: {
//                        viewModel.selectedIndex = nil
//                    }, label: {
//                        Text("Voltar")
//                    })
//                }
//            } else {
//                ScrollView{
//                    VStack(alignment: .leading, spacing: 16){
//                        LazyVGrid(columns: gridRows, spacing: 16) {
//                            ForEach(Array(viewModel.users.enumerated()), id: \.element.id) {
//                                index,
//                                user in
//                                Button(
//                                    action: {
//                                        print("Vai ir pro foco")
//                                        print(index)
//                                        viewModel.selectedIndex = index
//
//                                    },
//                                    label: {
//                                        CardComponent(
//                                            kit: viewModel.users[index].kit,
//                                            name: viewModel.users[index].userName,
//                                            idPosition: viewModel.users[index].position.idPosition,
//                                            viewModel.users[index].position.positionName
//                                        )
//                                        .frame(width: 150)
//                                        .padding()
//
//                                    }
//
//                                )
//                            }
//                        }
//                    }
//                    .padding()
//                }
//            }
//        }.navigationTitle("Users API ").task {
//            await viewModel.fetchData()
//        }
//
//    }
//}
//
import SwiftUI

struct UserView: View {
    @StateObject var viewModel = UserViewModel()
    
    var gridRows: [GridItem] {
        [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    }
    
    var selectedUser: User? {
        guard let index = viewModel.selectedIndex,
              viewModel.users.indices.contains(index) else {
            return nil
        }
        return viewModel.users[index]
    }
    
    var body: some View {
        NavigationStack {
            if let user = selectedUser {
                VStack {
                    Text("Já tá no foco")
                        .font(.title2)
                        .padding(.bottom)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Button("Anterior") {
                            viewModel.previousUser()
                        }
                        Button("Próximo") {
                            viewModel.nextUser()
                        }
                        
                        Text(user.userName)
                            .font(.headline)
                        
                        Text("Kit: \(user.kit)")
                        Text("Cargo: \(user.position.namePosition)")
                    }
                    .padding()
                    
                    Button("Voltar") {
                        viewModel.selectedIndex = nil
                    }
                    .padding(.top)
                }
                .padding()
                .navigationTitle("AcaDex") // ✅ aqui está dentro do if
                .task {
                    await viewModel.fetchData()
                }
            } else {
                ScrollView {
                    VStack{
                        LazyVGrid(columns: gridRows, spacing: 32) {
                            ForEach(Array(viewModel.users.enumerated()), id: \.element.idUser) { index, user in
                                Button {
                                    print("Vai ir pro foco")
                                    print(index)
                                    viewModel.selectedIndex = index
                                } label: {
                                    CardComponent(
                                        kit: user.kit,
                                        name: user.userName,
                                        idPosition: user.position.idPosition,
                                        positionName: user.position.namePosition
                                    )
                                    .padding(32)
                                }
                            }
                        }
                        .padding(16)
                    }
                    .padding()
                }
                .navigationTitle("AcaDex") // ✅ aqui está dentro do else
                .task {
                    await viewModel.fetchData()
                }
            }
        }
    }
}

#Preview {
    UserView()
}


