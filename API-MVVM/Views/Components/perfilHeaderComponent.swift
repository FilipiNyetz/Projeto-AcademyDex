//import SwiftUI
//
//struct AcademyDexHeaderProfile: View {
//    @Environment(\.dismiss) private var dismiss
//
//    var body: some View {
//        ZStack {
//            // Fundo azul
//            Color(red: 28/255, green: 45/255, blue: 112/255)
//                .ignoresSafeArea(edges: .top)
//                .frame(height: 150)
//            
//            VStack {
//                HStack {
//                    Button(action: {
//                        dismiss()
//                    }) {
//                        Image(systemName: "chevron.left")
//                            .font(.title)
//                            .foregroundColor(.white)
//                    }
//                    Spacer()
//                }
//                .padding(.horizontal)
//                .padding(.top, 20)
//                
//                HStack(spacing: 0) {
//                    Text("Academy")
//                        .font(.system(size: 48, weight: .bold, design: .rounded))
//                        .foregroundColor(.white)
//                    Text("Dex")
//                        .font(.system(size: 48, weight: .bold, design: .rounded))
//                        .foregroundColor(.red)
//                }
//                .frame(maxWidth: .infinity)
//                .padding(.top, 10)
//                Spacer()
//            }
//            .frame(height: 150)
//        }
//        .frame(height: 150)
//    }
//}
//
import SwiftUI

struct AcademyDexHeaderProfile: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            // Fundo azul
            Color(red: 28/255, green: 45/255, blue: 112/255)
                .ignoresSafeArea(edges: .top)
                .frame(height: 216) // altura igual ao header principal

            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 20)
                    Spacer()
                }
                .padding(.top, 60) // alinhamento vertical igual ao campo de busca

                HStack(spacing: 0) {
                    Text("Academy")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    Text("Dex")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.red)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 20) // espaço extra para alinhar com o outro header
            }
        }
    }
}

#Preview {
    AcademyDexHeaderProfile()
}
