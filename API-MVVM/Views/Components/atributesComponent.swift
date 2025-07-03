//
//  AtributesView.swift
//  AcademyDex
//
//  Created by Lucas Vasconcellos Côrtes on 6/30/25.
//
import SwiftUI

struct atributesComponent: View {
    let tela: String
    let cargo: String
    
    var body: some View {
        var altura: CGFloat {
            tela == "Perfil" ? 40 : 30
        }
        var largura: CGFloat {
            tela == "Perfil" ? 260 : 130
        }
        var fonte: Font{
            tela == "Perfil" ? .body : .subheadline
        }
        
        ZStack{
            Rectangle()
                .foregroundColor(Color(hex: decidirCor(cargo)))
                .cornerRadius(20)
            
            HStack{
                if tela == "Perfil" {
                    Text("Tipo")
                    Spacer()
                }
                Image(MudarIcon(cargo))
                Text("\(cargo)")
            }
            .padding(.horizontal)
            .font(fonte)
            .foregroundStyle(Color.white)
            .fontWeight(.heavy)
        }
        .frame(width: CGFloat(largura), height: CGFloat(altura))
        
    }
}

func decidirCor(_ cargo: String) -> UInt{
    switch cargo{
        case "Coder":
            return 0x4380A6 //Azul coder
        case "Designer":
            return 0x8866CD //Roxo Designer
        case "Mentor":
            return 0x0F3A55 //Azul mentor
        case "Mentor Jr":
            return 0xA13C3C //Cor mentor jr
        case "Suporte":
            return 0xD6AB00 //Amarelo Suporte
        default:
            return 0x4380A6 //Azul coder
    }
}

func MudarIcon(_ cargo: String) -> String{
    switch cargo{
    case "Coder":
        return "CoderIcon" //Icone coder
    case "Designer":
        return "DesignerIcon" //Icone Designer
    case "Mentor":
        return "MentorIcon" //Icone mentor
    case "Mentor Jr":
        return "MentorJrIcon" //Icone mentor jr
    case "Suporte":
        return "SuporteIcon"
    default:
        return ""
    }
}

#Preview {
    atributesComponent(tela: "home", cargo: "Coder")
}
