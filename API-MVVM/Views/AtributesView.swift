//
//  AtributesView.swift
//  AcademyDex
//
//  Created by Lucas Vasconcellos Côrtes on 6/30/25.
//

import SwiftUI

struct AtributesView: View {
    let person: PersonModel
    let tela: String
    
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
                .foregroundColor(Color(hex: decidirCor(person.cargo)))
                .cornerRadius(20)
            
            HStack{
                if tela == "Perfil" {
                    Text("Tipo")
                    Spacer()
                }
                Image(MudarIcon(person.cargo))
                Text("\(person.cargo)")
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
        case "Mentor Junior":
            return 0xA13C3C //Cor mentor jr
        case "Suporte":
            return 0xFFCC00
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
    case "Mentor Junior":
        return "MentorJrIcon" //Icone mentor jr
    case "Suporte":
        return ""
    default:
        return ""
    }
}

#Preview {
    AtributesView(person: PersonModel(name: "Lucas", kit: 732, cargo: "Designer", aniversario: "06/11"), tela: "Perfil")
}
