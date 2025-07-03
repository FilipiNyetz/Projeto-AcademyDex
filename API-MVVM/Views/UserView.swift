import SwiftUI

struct UserView: View {
    @StateObject var viewModel = UserViewModel()
    @State private var showFilter = false
    @State var showAddUser: Bool = false

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
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    // Cabeçalho
                    AcademyDexHeader(showFilter: $showFilter)
                        .padding(.top, -80)

                    // Conteúdo
                    ScrollView {
                        VStack(spacing: 16) {
                            // Grid de usuários
                            LazyVGrid(columns: gridRows, spacing: 48) {
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
                }

                // Floating Button dentro da NavigationStack
                Button(action: {
                    print("vai add")
                    showAddUser = true
                }) {
                    ZStack {
                        Circle()
                            .frame(width: 48, height: 48)
                            .foregroundColor(.white)
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 48, height: 48)
                    }
                }
                .padding()
            }
            // Modais
            .sheet(isPresented: $showFilter) {
                FilterComponent(viewModel: viewModel)
            }
            .sheet(isPresented: $showAddUser) {
                CreateUserView(viewModel: viewModel)
            }
            .task {
                await viewModel.fetchData()
            }
        }
    }
}

#Preview {
    UserView()
}


