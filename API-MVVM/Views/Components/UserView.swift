import SwiftUI

struct UserView: View {
    @StateObject var viewModel = UserViewModel()
    @State private var showFilter = false //para o botao de filtragem

    var gridRows: [GridItem] {
        [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
    }

    var body: some View {
        //para que possa refletir a filtragem na tela
        let list: [User] = viewModel.isFilterActive ? viewModel.usersFilter : viewModel.users

        NavigationView {
            if viewModel.selectedIndex != nil {
                VStack {
                    
                    Text("Ja ta no foco")
                    VStack(alignment: .leading, spacing: 4) {
                        
                        let user = viewModel.users[viewModel.selectedIndex ?? 0]
                        Button(action: {
                            viewModel.previousUser()
                        },label: {
                            Text("Anterior")
                        })
                        Button(action: {
                            viewModel.nextUser()
                        },label: {
                            Text("Proximo")
                        })
                        Text(user.userName)
                            .font(.headline)
                        Text("\(user.kit)")

                        Text("Cargo: \(user.position.namePosition)")
                    }
                    Button(action: {
                        viewModel.selectedIndex = nil
                    }, label: {
                        Text("Voltar")
                    })
                }
            } else {

                ScrollView {
                    Button(action: { // botao adicionado
                        print("Entrou nos Filtros")
                        showFilter = true
                    }) {
                        Text("Abrir Filtro")
                    }
                    VStack(alignment: .leading, spacing: 16){
                        LazyVGrid(columns: gridRows, spacing: 16) {
                            ForEach(Array(list.enumerated()), id: \.element.id) { index, user in
                                Button(
                                    action: {
                                        print("Vai ir pro foco")
                                        print(index)
                                        viewModel.selectedIndex = index
                                    },
                                    label: {
                                        CardComponent(
                                            kit: user.kit,
                                            name: user.userName,
                                            idPosition: user.position.idPosition
                                        )
                                        .frame(width: 150)
                                        .padding()
                                    }
                                )
                            }
                        }
                        //verificação para quando ninguém for encontrado na filtragem :
                        if list.isEmpty {
                            Text("Ninguém foi encontrado com os filtros selecionados.")
                                .foregroundColor(.gray)
                                .italic()
                                .padding()
                        }

                    }
                    .padding()
                }
            }
        }
        //metodo para o funcionamento do modal
        .sheet(isPresented: $showFilter) {
            FilterComponent(viewModel: viewModel)
        }
        .navigationTitle("Users API ").task {
            await viewModel.fetchData()
        }
    }
}

#Preview {
    UserView()
}
