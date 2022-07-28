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
//    let item: ItemModel?
    
//    init() {
//        if item != nil {
//            self.isEdit.toggle()
//            self.taskTitle = item!.title
//            self.taskLink = item!.link
//        }
//    }
    
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
            .navigationTitle(isEdit ? "Edit Task" : "New Task")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(Color(#colorLiteral(red: 0, green: 0.6907485723, blue: 0.9246113896, alpha: 1)))
                    })
            )
            .alert(isPresented: $showAlert, content: getAlert)
        }
        .environmentObject(ListViewModel())
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(title: taskTitle, link: taskLink)
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
        AddView()
    }
}
