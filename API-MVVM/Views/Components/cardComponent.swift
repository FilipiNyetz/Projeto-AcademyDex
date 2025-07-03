import SwiftUI

//ID position coder: "7e2f7693-df26-4dcd-9fb1-c39c0b11ecf4"

//Id position mentor: 8b12014b-9463-4a4f-91e3-ed1fc5bb8ff8

struct CardComponent: View {
    var kit: Int
    var name: String
    var idPosition: String
    let positionName: String

    var body: some View {
        
       
        let position = PositionType.from(id: idPosition)

        VStack{
            VStack(alignment: .leading) {
                Image(position.imagePerfilPhoto)

                Text(name)
                    .bold()
                    .foregroundColor(.primary)
                
                Text("Kit: \(kit)")
                    .foregroundColor(.secondary)

//                Image(position.imageName)
//                    .resizable()
//                    .frame(width: 72, height: 32)
                atributesComponent(tela: "home", cargo: positionName.capitalized)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .frame(width: 128, height: 144)
        }
    }
}



#Preview {
   CardComponent(kit: 11, name: "rebeca", idPosition: "8b12014b-9463-4a4f-91e3-ed1fc5bb8ff8", positionName: "Coder")
}
