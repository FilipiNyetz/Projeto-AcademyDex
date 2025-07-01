import SwiftUI

struct UserView: View {
    @StateObject var viewModel = UserViewModel()
    
    var gridRows: [GridItem] {
        [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    }
    
    var body: some View {

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
                ScrollView{
                    VStack(alignment: .leading, spacing: 16){
                        LazyVGrid(columns: gridRows, spacing: 16) {
                            ForEach(Array(viewModel.users.enumerated()), id: \.element.id) {
                                index,
                                user in
                                Button(
                                    action: {
                                        print("Vai ir pro foco")
                                        print(index)
                                        viewModel.selectedIndex = index

                                    },
                                    label: {
                                        CardComponent(
                                            kit: viewModel.users[index].kit,
                                            name: viewModel.users[index].userName,
                                            idPosition: viewModel.users[index].position.idPosition
                                        )
                                        .frame(width: 150)
                                        .padding()
                                        
                                    }
                                    
                                )
                            }
                        }
                    }
                    .padding()
                }
            }
        }.navigationTitle("Users API ").task {
            await viewModel.fetchData()
        }

    }
}

//#Preview {
//    UserView()
//}
