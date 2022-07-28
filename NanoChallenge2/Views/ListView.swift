//
//  ListView.swift
//  NanoChallenge2
//
//  Created by anggidast on 25/07/22.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var showingAddModal = false
    var body: some View {
        ZStack {
            ScrollView {
                ForEach(listViewModel.items, id: \.id.self) { item in
                    VStack {
                        ListRowView(item: item)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                }
            }
            .padding(.top, 5)
            .padding(.bottom, 75)
            
            VStack {
                Spacer()
                Button(action: {
                    showingAddModal.toggle()
                }, label: {
                    Text("+ Add New Task")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color(#colorLiteral(red: 0.3671092689, green: 0.7148341537, blue: 0.8327456117, alpha: 1)))
                        .cornerRadius(10)
                })
                
            }
            .padding(16)
        }
        .navigationTitle("Welcome, Anggi")
        .sheet(isPresented: $showingAddModal) {
            AddView(item: ItemModel(id: 0, title: "", link: "", isDone: false))
        }
        .background(Color(#colorLiteral(red: 0.949019134, green: 0.9490200877, blue: 0.9705254436, alpha: 1)))
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}
