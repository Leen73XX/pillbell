//
//  ContentView.swift
//  pillbell
//
//  Created by Leen Almejarri on 08/06/1445 AH.
//

import SwiftUI
import SwiftData
import EventKit

struct ContentView: View {
    
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) var colorScheme
    @Query private var items: [Item]
    @State private var showSettingsMenu = false
    var body: some View {
       
            
            //                .background(colorScheme == .dark ? Color.black : Color.black)
            
            NavigationStack {
                ScrollView{
                    
                    
                    
                    Button(action: {
                        showSettingsMenu.toggle()
                    }) {
                        Label("select date", systemImage: "").padding(.trailing, 250.0)}
                    
                    
                    
                    .navigationTitle("my pills")
                    
                    VStack{
                        if showSettingsMenu {
                            Calender(interval: DateInterval(start:.distantPast, end: .distantPast),eventStore: EKEventStore())
                        }
                        List {
                            ForEach(items) { item in
                                NavigationLink {
                                    Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                                }
                            label: {
                                Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                            }
                                
                            }
                            
                            .onDelete(perform: deleteItems)
                        }
                        
                    }
                }.toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
                
                
                
            }
        }
            
        
    
    private func cal(){
       
   }
        private func addItem() {
            
            withAnimation {
                let newItem = Item(timestamp: Date())
                modelContext.insert(newItem)
              
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
