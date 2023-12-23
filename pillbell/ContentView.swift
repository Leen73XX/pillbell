//
//  ContentView.swift
//  pillbell
//
//  Created by Leen Almejarri on 08/06/1445 AH.
//

import SwiftUI
import SwiftData
import EventKit

struct Pill: Identifiable {
    var id: ObjectIdentifier
    var title: String
    public func gettititle ()-> String{
        return title
    }
}
struct pillRow : View {
    var pil: Pill
    var body: some View {
        Text(pil.title)
            .font(.headline)
    }
}

struct ContentView: View {
    
    @State private var Pills: [Pill] = []
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) var colorScheme
    @Query private var items: [Item]
    @State private var showSettingsMenu = false
    @State private var Add = false
    @Environment(\.presentationMode) var presentationMode
    @State private var save = false

    var body: some View {
        
        
        //                .background(colorScheme == .dark ? Color.black : Color.black)
       
        NavigationView {
           
            ScrollView{
                
               

                Button(action: {
                    showSettingsMenu.toggle()
                }) {
                    Label("select date", systemImage: "").padding(.trailing, 250.0)}

                

                .navigationTitle("my pills")
                if showSettingsMenu {
                    Calender(interval: DateInterval(start:.distantPast, end: .distantPast),eventStore: EKEventStore())
                }
                
                NavigationSplitView {
                        
                       
                            List {
                                ForEach(items) { item in
                                    NavigationLink {
                                        Text("Item at \(item.pillName)")
                                    }
                                label: {
                                    Text(item.pillName)
                                }
                                    
                                }
                                
                                .onDelete(perform: deleteItems)
                            }
                            .toolbar {
                                ToolbarItem(placement: .navigationBarLeading){ Text("to take")
                                    .font(.title)}
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    EditButton()
                                }
                                ToolbarItem {
                                    Button(action: {Add.toggle()}) {
                                        Label("Add pill", systemImage: "plus")
                                    }
                                }
                            }
                            
                        

                    }
            detail: {
                        Text("Select an item")

                    
                }
        }
                
                
                
                
        } .sheet(isPresented: $Add) {
            add(pill: "")
        }
        }
            
    struct add: View{
        @Environment(\.presentationMode) var presentationMode
        @State private var save = false
        var pill: String
        var body: some View {
            Text("hh")
//            TextField("إسم المشروع", text: $title)
//                .foregroundColor(.gray)
//                .padding()
//            //.keyboardType()
//                .background(Color.white)
//                .cornerRadius(10)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(Color.ourgreen, lineWidth: 1)
//                )
//                .padding(.horizontal, 20)
            Button(action: {
                save = true
                
                presentationMode.wrappedValue.dismiss()
//                let newPill = Pill(
//                    title: title
//                )
//             
//             if let index = Pills.firstIndex(where: { $0.title == newPill.title }) {
//                 Pills[index] = newPill
//             } else {
//                 Pills.append(newPill)
//             }
//             dismissAction()
            }) {
                Text("حفظ")
            }}
    }
    
    private func addItem2(){
       
   }
        private func addItem() {
            
            withAnimation {
                let newPill = Item(pillName: String())
              
                modelContext.insert(newPill)
              
              
            }
        }
        
        private func deleteItems(offsets: IndexSet) {
            withAnimation {
                for index in offsets {
                    modelContext.delete(items[index])
                }
            }
        }
    }


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
