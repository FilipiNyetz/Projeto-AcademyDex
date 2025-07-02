//
//  UserViewModel.swift
//  API-MVVM
//
//  Created by Filipi Romão on 30/06/25.
//
import Foundation

class UserViewModel: ObservableObject {
   
    @Published var users: [User] = []
    @Published var usersFilter: [User] = []

    @Published var selectedIndex: Int? = nil
    
    @Published var selectedType = "Todos"
    @Published var selectedSortOption: String = "Menor número primeiro"
    @Published var selectedMonths: Set<String> = []
    @Published var isFilterActive: Bool = false

    
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
                print("Positions:", users.map { $0.position.namePosition })//adicionei somente para verificar as posicoes
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
    
    // MARK: - Função
    func aplicarFiltro() {
        // Começa com todos os usuários
        var resultado = users

        // 1. Filtrar por tipo/cargo (position.namePosition)
        if selectedType != "Todos" {
            resultado = resultado.filter { $0.position.namePosition == selectedType }
        }

        // 2. Filtrar pelos meses de nascimento (birthDate em formato ISO 8601)
        if !selectedMonths.isEmpty {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            formatter.locale = Locale(identifier: "pt_BR")

            resultado = resultado.filter { user in
                if let date = formatter.date(from: user.birthday) {
                    let mes = Calendar.current.component(.month, from: date)
                    let nomeMes = formatter.monthSymbols[mes - 1].capitalized
                    return selectedMonths.contains(nomeMes)
                }
                return false
            }
        }

        // 3. Ordenar
        if selectedSortOption == "Menor número primeiro" {
            resultado.sort { $0.kit < $1.kit }
        } else {
            resultado.sort { $0.kit > $1.kit }
        }

        // 4. Atribuir resultado filtrado
        usersFilter = resultado
        isFilterActive = true // <-- diz que um filtro foi aplicado
    }
}
