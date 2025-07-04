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
    
    
    // Campos para criação de novo usuário
    @Published var newUserName: String = ""
    @Published var newKit: String = ""
    @Published var newBirthday: Date = Date()
    @Published var newPosition: String = ""
    
    @Published var userToSearch: String = ""
    
    @Published var userCreated : Bool = false
    @Published var showAlert: Bool = false
    
    let positionNameToId: [String: String] = [
        "Coder": "7e2f7693-df26-4dcd-9fb1-c39c0b11ecf4",
        "Mentor": "8b12014b-9463-4a4f-91e3-ed1fc5bb8ff8",
        "Designer": "bc8c4ea9-c88f-4f82-a60b-c921536a88b9",
        "Mentor Jr": "d69ee0db-32f2-4985-93b6-01e17a713fdc"
    ]
    
    var positionOptions: [String] {
        Array(positionNameToId.keys)
    }
    
    struct NewUser: Codable{
        var userName: String = ""
        var kit: Int = 0
        var birthday: Date = Date()
        var idPosition: String = ""
    }
    
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
    
    func createUser() async {
        guard let kitInt = Int(newKit) else {
            print("Kit inválido")
            return
        }
        
        guard let idPosition = positionNameToId[newPosition] else {
            print("Posição inválida")
            return
        }
        
        let userToSend = NewUser(
            userName: newUserName,
            kit: kitInt,
            birthday: newBirthday,
            idPosition: idPosition
        )
        
        guard let url = URL(string: "https://hopeful-creativity-production.up.railway.app/api/user/createUser") else {
            print("URL inválida")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let jsonData = try encoder.encode(userToSend)
            request.httpBody = jsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
                if httpResponse.statusCode == 201 {
                    userCreated = true
                    
                    newUserName = ""
                    newKit = ""
                    newBirthday = Date()
                    newPosition = ""
                    
                    await fetchData()
                    
                }
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Resposta do servidor: \(responseString)")
            }
            
        } catch {
            print("Erro ao codificar ou enviar: \(error)")
        }
    }
 
    func searchUser(query: String) {
        if query.isEmpty {
            isFilterActive = false
        } else {
            usersFilter = users.filter { user in
                user.userName.lowercased().contains(query.lowercased())
            }
            isFilterActive = true
        }
    }
        
}
