//
//  ListRowView.swift
//  NanoChallenge2
//
//  Created by anggidast on 25/07/22.
//

import SwiftUI

struct ListRowView: View {
    @State private var showingAddModal = false
    @EnvironmentObject var listViewModel: ListViewModel
    let item: ItemModel
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                Button(action: {
                   //
                }, label: {
                    Text("Open Link")
                        .foregroundColor(.white)
                        .frame(width: 90, height: 30)
                        .background(Color(#colorLiteral(red: 0.3671092689, green: 0.7148341537, blue: 0.8327456117, alpha: 1)))
                        .cornerRadius(10)
                })
            }
            Spacer()
            Image(systemName: item.isDone ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 24.0, height: 24.0)
                .foregroundColor(item.isDone ? Color(#colorLiteral(red: 0.3671092689, green: 0.7148341537, blue: 0.8327456117, alpha: 1)) : Color(#colorLiteral(red: 0.6000000834, green: 0.6000000834, blue: 0.6000000834, alpha: 1)))
                .onTapGesture {
                    withAnimation(.linear) {
                        listViewModel.updateItem(item: item)
                    }
                }
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .onTapGesture {
            showingAddModal.toggle()
            listViewModel.isEdit.toggle()
        }
        .sheet(isPresented: $showingAddModal) {
            AddView()
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var item1 = ItemModel(id: 1, title: "First item", link: "https://link1", isDone: true)
    static var item2 = ItemModel(id: 2, title: "Second item", link: "https://link2", isDone: false)
    
    static var previews: some View {
        Group {
            ListRowView(item: item1)
            ListRowView(item: item2)
        }
        .previewLayout(.sizeThatFits)
    }
}
