//
//  Filtro.swift
//  Componente
//
//  Created by Késia Silva Viana on 30/06/25.
//

import SwiftUI

struct FilterComponent: View {
    @ObservedObject var viewModel: UserViewModel

    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme

    // MARK: - Tipos que contém no JSON como coder, designer..
    var types: [String] {
        let positions = viewModel.users.map { $0.position.namePosition }
        let position = Set(positions)
        return ["Todos"] + Array(position).sorted()
    }

    // MARK: - Dados para os filtros
    let sortOptions = ["Menor número primeiro", "Maior número primeiro"]
    let months: [String] = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.monthSymbols.map { $0.capitalized }
    }()

    var body: some View {
        VStack(spacing: 22) {
            Text("Filtros")
                .font(.headline)

            filtroMenu(titulo: "Tipo", selecao: $viewModel.selectedType, opcoes: types)
            filtroMenu(titulo: "Organizar por", selecao: $viewModel.selectedSortOption, opcoes: sortOptions)

            // MARK: - Grade de meses
            VStack(alignment: .leading, spacing: 8) {
                Text("Mês de Aniversário")
                    .font(.headline)

                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3), spacing: 10) {
                    ForEach(months, id: \.self) { mes in
                        Button(action: {
                            if viewModel.selectedMonths.contains(mes) {
                                viewModel.selectedMonths.remove(mes)
                            } else {
                                viewModel.selectedMonths.insert(mes)
                            }
                        }) {
                            Text(mes.prefix(3))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(viewModel.selectedMonths.contains(mes) ? Color.orange : Color.gray.opacity(0.2))
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                        }
                    }
                }
            }

            // MARK: - Botões de ação
            HStack {
                Button("Redefinir") {
                    viewModel.selectedType = "Todos"
                    viewModel.selectedSortOption = "Menor número primeiro"
                    viewModel.usersFilter = []
                    viewModel.selectedMonths.removeAll()
                    viewModel.isFilterActive = false
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button(action: {
                    // Lógica de pesquisa
                    viewModel.aplicarFiltro()
                    dismiss()
                    print("pesquisou")
                }) {
                    Label("Pesquisar", systemImage: "magnifyingglass")
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.top)

            Spacer()
        }
        .padding()
        .task {
            await viewModel.fetchData()
        }
    }

    // MARK: - Componente reutilizável dos menus
    private func filtroMenu(titulo: String, selecao: Binding<String>, opcoes: [String]) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(titulo)
                .font(.headline)

            Menu {
                ForEach(opcoes, id: \.self) { opcao in
                    Button(opcao) {
                        selecao.wrappedValue = opcao
                    }
                }
            } label: {
                HStack {
                    Text(selecao.wrappedValue)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.colorBlue)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 4)
            }
        }
    }
}

#Preview {
    FilterComponent(viewModel: UserViewModel())
}
