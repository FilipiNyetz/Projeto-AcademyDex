import SwiftUI

struct UserVieww: View {
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
            ScrollView {
                VStack{
                    LazyVGrid(columns: gridRows, spacing: 32) {
                        ForEach(Array(viewModel.users.enumerated()), id: \.element.idUser) { index, user in
                            NavigationLink(destination: ProfileView(index: index)){
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
                }
                .padding(16)
            }
            .padding()
        }
        .task {
            await viewModel.fetchData()
        }
    }
    
}

#Preview {
    UserVieww()
}
