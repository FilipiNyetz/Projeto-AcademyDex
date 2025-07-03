import SwiftUI

struct UserView: View {
    @StateObject var viewModel = UserViewModel()
    @State private var showFilter = false

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

    var list: [User] {
        viewModel.isFilterActive ? viewModel.usersFilter : viewModel.users
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // Botão para abrir filtro
                    Button("Abrir Filtro") {
                        showFilter = true
                    }
                    .padding(.bottom)

                    // Grid de usuários
                    LazyVGrid(columns: gridRows, spacing: 32) {
                        ForEach(Array(list.enumerated()), id: \.element.idUser) { index, user in
                            NavigationLink(destination: ProfileView(index: index, lista: list)) {
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

                    // Mensagem quando nenhum resultado for encontrado
                    if list.isEmpty {
                        Text("Ninguém foi encontrado com os filtros selecionados.")
                            .foregroundColor(.gray)
                            .italic()
                            .padding()
                    }
                }
                .padding(16)
            }
            .padding()
            .navigationTitle("Usuários")
        }
        // Apresenta o modal de filtro
        .sheet(isPresented: $showFilter) {
            FilterComponent(viewModel: viewModel)
        }
        .task {
            await viewModel.fetchData()
        }
    }
}

#Preview {
    UserView()
}
