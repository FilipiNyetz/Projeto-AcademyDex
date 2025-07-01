//
//  UserViewModel.swift
//  API-MVVM
//
//  Created by Filipi Romão on 30/06/25.
//
import Foundation

class UserViewModel: ObservableObject {
   
    @Published var users: [User] = []
    @Published var selectedIndex: Int? = nil
    
    func fetchData() async {
        print("Entrou na funcao fetchData")
        guard let url = URL(string: "https://hopeful-creativity-production.up.railway.app/api/user/listUser") else{
            print("URL invalida")
            return
        }
        do{
            print("Entrou no bloco do")
            let (data,_) = try await URLSession.shared.data(from: url)
            
            if let decodeResponse = try? JSONDecoder().decode([User].self, from: data){
                users = decodeResponse
            }
        }catch{
            print("Esses dados nao sao validos ")
        }
    }
    
    func nextUser(){
        if selectedIndex == users.count{
            print("chegou no limite")
        }else{
            selectedIndex! += 1
        }
    }
    
    func previousUser(){
        if selectedIndex == 0{
            print("chegou no limite")
        }else{
            selectedIndex! -= 1
        }
    }
}

