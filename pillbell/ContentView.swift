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
    
    
    
    @State private var selectedMonth = "January"
        let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) var colorScheme
    @Query private var items: [Item]
    @State private var showMenu = false
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
                    showMenu.toggle()
                }) {
                    Label("\(selectedMonth)", systemImage: "").padding(.trailing, 300.0)}
                
                
                
                .navigationTitle("my pills")
                
           
                if showMenu {
                    HStack{
                        VStack {
                            Picker("Select a month", selection: $selectedMonth) {
                                ForEach(months, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            
                            
                        }
                        Spacer()
                          
                    }
                }
                ScrollView(.horizontal) {
                         HStack(spacing: 20) {
                             ForEach(1..<32) { number in
                                 ZStack{
                                     RoundedRectangle(cornerRadius: 10)
                                         .frame(width: 100, height: 100)
                                         .foregroundColor(.blue)
                                     VStack{
                                         Spacer()
                                         Text("\(number)")
                                             .font(.largeTitle)
                                             .fontWeight(.bold)
                                             .foregroundColor(Color.white)
                                         Text("\(selectedMonth)")
                                             .font(.body)
                                             .fontWeight(.bold)
                                             .foregroundColor(Color.white)
                                            
                                         
                                         
                                         Spacer()
                                     }
                                 }
                             }
                         }
                         .padding()
                     }
                
                NavigationSplitView {
                    
                    List{
                        
                        ForEach(pills) { pill in
                            
                            NavigationLink(destination: PillDetail(pill:  pill)) {
                                pillRow(pil: pill)
                            }
                        }
                            .onDelete{pills.remove(atOffsets: $0)}
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
                                Spacer()
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
    
    struct Pill: Identifiable {
        var id = UUID()
        var title: String
    
        public func gettititle ()-> String{
            return title
            
        }}
        // end Pill _____________________________________
        
        // start pillRow _____________________________________
        struct pillRow : View {
            var pil: Pill
            var body: some View {
                VStack(spacing: 20){
                    HStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 15).frame(width: 50,height: 50)
                                .foregroundColor(.blue)
                            VStack{
                               Text("")
                            }
                        }
                        VStack{
                            Text(pil.title)
                                .font(.headline)
                            Text("\(pil.title)")
                        }
                    }
                }
               
            }
        }
        // ena pillRow __________________________________
        
        // start add _________________________________________
        struct add: View{
            
              
            @Environment(\.managedObjectContext) private var viewContext
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
                Text("pill information")
                TextField("pill name", text: $title)
                    .foregroundColor(.gray)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
//                HStack {
//                    
//                    Text("Selected number: \(selectedNumber)")
//                    
//                    Picker("Select a number", selection: $selectedNumber) {
//                        ForEach(numbers, id: \.self) { number in
//                            Text("\(number)")
//                        }
//                    }
//                    .pickerStyle(WheelPickerStyle())
//                }
                
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
                }
            }
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
                modelContext.delete(items[index])
            }
        }
    }
   
    }
// end ContentView _____________________________________

#Preview {
    ContentView()
       
}
