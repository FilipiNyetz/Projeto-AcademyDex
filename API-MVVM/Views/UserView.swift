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
    
    //    var body: some View {
    //        ZStack(alignment: .bottomTrailing){
    //            NavigationStack {
    //                AcademyDexHeader(showFilter: $showFilter, viewModel: viewModel)
    //                    .padding(.top, -80)
    //                ScrollView {
    //                    VStack(spacing: 16) {
    //                        // Grid de usuários
    //                        LazyVGrid(columns: gridRows, spacing: 48) {
    //                            ForEach(Array(list.enumerated()), id: \.element.idUser) { index, user in
    //                                NavigationLink(destination: ProfileView(index: index, lista: list, viewModel: viewModel)) {
    //                                    CardComponent(
    //                                        kit: user.kit,
    //                                        name: user.userName,
    //                                        idPosition: user.position.idPosition,
    //                                        positionName: user.position.namePosition
    //                                    )
    //                                    .padding(32)
    //
    //                                }
    //                            }
    //                        }
    //
    //
    //                        // Mensagem quando nenhum resultado for encontrado
    //                        if list.isEmpty {
    //                            Text("Ninguém foi encontrado com os filtros selecionados.")
    //                                .foregroundColor(.gray)
    //                                .italic()
    //                                .padding()
    //                        }
    //                    }
    //
    //                    .padding(16)
    //                }
    //                .ignoresSafeArea(.container, edges: [.bottom])
    //                }
    //            HStack{
    //                Spacer()
    //                Button(action: {
    //                    print("vai add")
    //                    showAddUser = true
    //                }, label:{
    //                    ZStack{
    //                        Circle()
    //                            .fill(Color.white)
    //                            .frame(width: 48, height: 48)
    //                        Image(systemName: "plus.circle.fill")
    //                            .resizable()
    //                            .frame(width: 48, height: 48)
    //                    }
    //                })
    //            }
    //            .padding()
    //            .sheet(isPresented: $showAddUser) {
    //                CreateUserView(viewModel: viewModel)
    //            }
    //            .sheet(isPresented: $showFilter) {
    //                FilterComponent(viewModel: viewModel)
    //            }
    //
    //            // Apresenta o modal de filtro
    //        }
    //        .task {
    //            await viewModel.fetchData()
    //        }
    //    }
    //}
    //
    //#Preview {
    //    UserView()
    //}
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                VStack(spacing: 0) {
                    AcademyDexHeader(showFilter: $showFilter, viewModel: viewModel)
                        .padding(.top, -80)
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            LazyVGrid(columns: gridRows, spacing: 48) {
                                ForEach(Array(list.enumerated()), id: \.element.idUser) { index, user in
                                    NavigationLink(destination: ProfileView(index: index, lista: list, viewModel: viewModel)) {
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
                            
                            if list.isEmpty {
                                Text("Ninguém foi encontrado com os filtros selecionados.")
                                    .foregroundColor(.gray)
                                    .italic()
                                    .padding()
                            }
                        }
                        .padding(16)
                    }
                    .ignoresSafeArea(.container, edges: [.bottom])
                    .padding(.top, 16)
                }
                // Botão flutuante dentro da NavigationStack, mas fora do ScrollView
                Button(action: {
                    showAddUser = true
                }, label: {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 48, height: 48)
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 48, height: 48)
                    }
                })
                .padding()
            }
            // Sheets ainda dentro da NavigationStack
            .sheet(isPresented: $showAddUser) {
                CreateUserView(viewModel: viewModel)
            }
            .sheet(isPresented: $showFilter) {
                FilterComponent(viewModel: viewModel)
            }
        }
        .task {
            await viewModel.fetchData()
        }
    }
}

#Preview {
    UserView()
}
