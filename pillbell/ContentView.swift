//
//  ContentView.swift
//  pillbell
//
//  Created by Leen Almejarri on 08/06/1445 AH.
//

import SwiftUI
import SwiftData
import EventKit


// start ContentView ____________________________________
struct ContentView: View {
    
  
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) var colorScheme
    
    @State private var showSettingsMenu = false
    @State private var Add = false
    @Environment(\.presentationMode) var presentationMode
    @State private var save = false
    @State private var isShowingAddPill = false
    @State private var pills: [Pill] = []
   

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
                                ForEach(pills) { p in
                                    NavigationLink {
                                        Text("Item at \(p.title)")
                                    }
                                label: {
                                    Text(p.title)
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
                                    Button(action: {Add.toggle()
                                    isShowingAddPill = true}) {
                                        Label("Add pill", systemImage: "plus")
                                    }
                                }
                            }
                            
                    VStack {
                        //Divider()
                        if pills.isEmpty {
                            Text("no pill added")
                                .foregroundColor(.gray)
                                .font(.headline)
                                
                        }
                        
                            
//                        List(pills) { pill in
//                            
//                            NavigationLink(destination: PillDetail(pill: pill)) {
//                                pillRow(pil: pill)
//                            }
//                            
//
//                        }
                        
                    }

                    }
            detail: {
                        Text("Select an item")

                    
                }
            

        }
                    } .sheet(isPresented: $Add) {
            add( pills: $pills, title: "" , dismissAction: {
                isShowingAddPill = false
            })
        }
        }
    
    // start Pill _____________________________________
    @Model
    struct Pill: Identifiable {
        var id = UUID()
        var title: String
        public func gettititle ()-> String{
            return title
        }
        init(id: UUID = UUID(), title: String) {
            self.id = id
            self.title = title
        }
    }
    // end Pill _____________________________________
    
    // start pillRow _____________________________________
    struct pillRow : View {
        var pil: Pill
        var body: some View {
            Text(pil.title)
                .font(.headline)
        }
    }
    // ena pillRow __________________________________
    
    // start add _________________________________________
    struct add: View{
        
        var dismissAction: () -> Void
        @Environment(\.presentationMode) var presentationMode
        @State private var save = false
        
        @Binding var pills: [Pill]
        @State private var title = ""
        
        init(pills: Binding<[Pill]>, title: String, dismissAction: @escaping () -> Void) {
                self._pills = pills
                self._title = State(initialValue: title)
                self.dismissAction = dismissAction
            }
        var body: some View {
            Text("hh")
            TextField("إسم المشروع", text: $title)
                .foregroundColor(.gray)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal, 20)
            Button(action: {
                save = true
                
                presentationMode.wrappedValue.dismiss()
                let newPill = Pill(
                     title: title
                )
             
             if let index = pills.firstIndex(where: { $0.title == newPill.title }) {
                 pills[index] = newPill
             } else {
                 pills.append(newPill)
             }
             dismissAction()
            }) {
                Text("حفظ")
            }}
    }
   // end add ________________________________________
    // start PillDetail_____________________________________
    struct PillDetail: View {
        var pill: Pill
        @State private var pills: [Pill] = []
        var body: some View {
            ScrollView {
                HStack{
                    
                    VStack(alignment: .leading) {
                        
                        
                        Text(pill.title)
                            .font(.title)
                            .padding()
                        
                    }}}}}
    //end PillDetail_______________________________________
//        private func addItem() {
//            
//            withAnimation {
//                let newPill = Item(pillName: String())
//              
//                modelContext.insert(newPill)
//              
//              
//            }
//        }
//        
        private func deleteItems(offsets: IndexSet) {
            withAnimation {
                for index in offsets {
                    modelContext.delete(pills[index])
                }
            }
        }
    }
// end ContentView _____________________________________


#Preview {
    ContentView()
       
}
