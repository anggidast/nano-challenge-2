//
//  AddView.swift
//  NanoChallenge2
//
//  Created by anggidast on 25/07/22.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var taskTitle: String = ""
    @State var taskLink: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    @State var isEdit: Bool = false
    let item: ItemModel
    
    init(item: ItemModel) {
        self.item = item
        _taskTitle = State(wrappedValue: item.title)
        _taskLink = State(wrappedValue: item.link)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack {
                        TextField("Task Title", text: $taskTitle)
                            .padding(.horizontal)
                            .frame(height: 55)
                            .background(Color(#colorLiteral(red: 0.8470588326, green: 0.8470589519, blue: 0.8470588326, alpha: 1)))
                            .cornerRadius(10)
                            .padding(.top)
                        
                        TextField("Task Link", text: $taskLink)
                            .padding(.horizontal)
                            .frame(height: 165)
                            .background(Color(#colorLiteral(red: 0.8470588326, green: 0.8470589519, blue: 0.8470588326, alpha: 1)))
                            .cornerRadius(10)
                            .padding(.vertical)
                    }
                    .padding(12)
                }
                .background(.white)
                .cornerRadius(10)
                .padding(14)
                
                Button(action: saveButtonPressed, label: {
                    Text("Save")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 40)
                        .frame(maxWidth: 100)
                        .background(Color(#colorLiteral(red: 0.3671092689, green: 0.7148341537, blue: 0.8327456117, alpha: 1)))
                        .cornerRadius(10)
                })
            }
            .background(Color(#colorLiteral(red: 0.949019134, green: 0.9490200877, blue: 0.9705254436, alpha: 1)))
            .navigationTitle(item.id != 0 ? "Edit Task" : "New Task")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(Color(#colorLiteral(red: 0, green: 0.6907485723, blue: 0.9246113896, alpha: 1)))
                    }),
                trailing:
                    Button(action: {
                        showAlert.toggle()
                    }, label: {
                        Image(systemName: item.id != 0 ? "trash" : "").imageScale(.large)
                            .foregroundColor(Color(#colorLiteral(red: 0.832049787, green: 0.4876412749, blue: 0.4552121758, alpha: 1)))
                    })
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Are you sure you want to delete this item?"),
                            message: Text("This action can not be undone!"),
                            primaryButton: .destructive(Text("Delete")) {
                                listViewModel.deleteItem(id: item.id)
                            },
                            secondaryButton: .cancel()
                        )
                    }
            )
            .alert(isPresented: $showAlert, content: getAlert)
        }
        .environmentObject(ListViewModel())
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            if item.id == 0 {
                listViewModel.addItem(title: taskTitle, link: taskLink)
            } else {
                let item: ItemModel = ItemModel(id: item.id, title: taskTitle, link: taskLink, isDone: item.isDone)
                listViewModel.updateItem(item: item)
            }
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if taskTitle.count < 1 || taskLink.count < 1 {
            alertTitle = "Title and link cannot be empty!"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(item: ItemModel(id: 1, title: "First item", link: "https://link1", isDone: true))
    }
}
