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
//    @State private var isChecked = false
    
    
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
    
    @State private var isChecked = false
    
    var body: some View {
        
        
        //                .background(colorScheme == .dark ? Color.black : Color.black)
        
        NavigationView {
            
            ScrollView{
                
                
                
                Button(action: {
                    showMenu.toggle()
                }) {
                    Label("selected Month", systemImage: "").accessibilityLabel("selected Month").accessibilityHint("select month from the list")
                    Spacer()
}
                
                
                
                .navigationTitle(selectedMonth).accessibilityLabel("\(selectedMonth)")
               
                
           
                if showMenu {
                    HStack{
                        VStack {
                            Picker("Select a month", selection: $selectedMonth) {
                                ForEach(months, id: \.self) {
                                    Text($0)
                                       
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .accessibilityAddTraits([.isHeader])
                            
                            
                        }
                        Spacer()
                          
                    }
                }
                ScrollView(.horizontal) {
                         HStack(spacing: 20) {
                             ForEach(1..<32) { number in
                                 ZStack{
                                     Button(action: {
                                         
                                         //
                                                         }) {
                                                             RoundedRectangle(cornerRadius: 15)
                                                                 .fill(Color.our)
                                                                 .frame(width: 100, height: 100)
                                                         }
                                     
                                     VStack{
                                         Spacer()
                                         Text("\(number)").accessibilityAddTraits([.isHeader])
                                             .font(.largeTitle)
                                             .fontWeight(.bold)
                                             .foregroundColor(Color.white)
                                         Text("\(selectedMonth)").accessibilityAddTraits([.isHeader])
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
//                        if(!pills.isEmpty){
//                            HStack{
//                                Toggle(isOn: $isChecked) {
//                                    Text("")
//                                }
//                                .toggleStyle(CheckboxToggleStyle())
//                            }}
                        ForEach(pills) { pill in
                            
                            HStack{
                                
                                HStack{
                                    
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 15).frame(width: 50,height: 50)
                                            .foregroundColor(.our)
                                        VStack{
                                            Text("25")
                                                .fontWeight(.bold)
                                                .foregroundColor(Color.white)
                                            Text("dec")
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                    VStack(alignment: .leading){
                                        Text("\(pill.medicationName)").accessibilityAddTraits([.isHeader])
                                            .font(.headline)
                                        Text("number of doses: \(pill.numberOfDoses)").accessibilityAddTraits([.isHeader])
                                        
                                        
                                        Text("\(pill.selectedFrequency)").accessibilityAddTraits([.isHeader])
                                    }
                                   
                                }
                                Toggle("", isOn: $isChecked)
                                if(isChecked == true){
                                    
                                }
//                                Button(action: {
//                                    pill.isChecked.toggle()
//                                }){
//                                    Image(systemName:pill.isChecked ? "checkmark.square.fill": "square")
//                                }
                            }
                            //                                Toggle("", isOn: $isChecked)

//                            NavigationLink(destination: PillDetail(pill:  pill)) {
//                                pillRow(pil: pill)
//                                 
//                            }
                            
                        }
                            .onDelete{pills.remove(atOffsets: $0)}
                        }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading){ Text("today pills").accessibilityAddTraits([.isHeader])
                            .font(.largeTitle)}
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton().accessibilityLabel("delete Pill").accessibilityHint("Tap to allow deleting pill from the list")

                        }
                        ToolbarItem {
                            Button(action: {Add.toggle()
                                isShowingAddPill = true}) {
                                    Label("Add pill", systemImage: "plus").accessibilityLabel("Add Pill").accessibilityHint("Tap to add a new pill to the list")

                                }
                        }
                    }
                    
                    VStack {
                        
                        //Divider()
                        if pills.isEmpty {
                            Text("no pill for today").accessibilityAddTraits([.isHeader])
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
                Text("Select pill")
                
                
            }
                
                
            }
            
        } .sheet(isPresented: $Add) {
            add( pills: $pills, medicationName: "" , dismissAction: {
                isShowingAddPill = false
            })
        }
    }
    
    // start Pill _____________________________________
    
    struct Pill: Identifiable {
        var id = UUID()
        var medicationName: String
        var numberOfDoses: Int
        var selectedFrequency:String
        var selectedDate:Date
        var isChecked : Bool = false
    
      }
        // end Pill _____________________________________
        
        // start pillRow _____________________________________
        struct pillRow : View {
            var pil: Pill
            
            @State private var isChecked = false

@State private var num = 25
            var body: some View {
               
                   
                VStack(spacing: 20){
                    HStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 15).frame(width: 50,height: 50)
                                .foregroundColor(.our)
                            VStack{
                                Text("\(num)")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                Text("dec")
                                    .foregroundColor(Color.white)
                            }
                        }
                        VStack(alignment: .leading){
                            Text(pil.medicationName)
                                .font(.headline)
                            Text("number of doses: \(pil.numberOfDoses)")
                                
                               
                            Text("\(pil.selectedFrequency)").accessibilityAddTraits([.isHeader])
                        }
                        
                    }
                }
               
            }
        }
        // ena pillRow __________________________________
        
        // start add _________________________________________
        struct add: View{
            
            // Declare variables for medication details
          

                   @State private var numberOfDoses: Int = 1
                   @State private var selectedFrequency: MedicationFrequency = .oncePerWeek
                   @State private var selectedDate: Date = Date()
                   @State private var selectedTime: Date = Date()
                   @State private var remindersEnabled: Bool = false
                
                    @State private var showingNewMedicationSheet = false
                
                // Enum for medication frequency options
                    enum MedicationFrequency: String, CaseIterable, Identifiable {
                        case oncePerDay = "Once per day"
                        case twicePerDay = "Twice per day"
                        case oncePerWeek = "Once per week"
                        case custom = "Ignore"

                        var id: String { self.rawValue }
                    }
            
            
            @Environment(\.managedObjectContext) private var viewContext
            var dismissAction: () -> Void
            @Environment(\.presentationMode) var presentationMode
            @State private var save = false
            
            @Binding var pills: [Pill]
            @State private var medicationName = ""
          
            
            init(pills: Binding<[Pill]>, medicationName: String, dismissAction: @escaping () -> Void) {
                self._pills = pills
                self._medicationName = State(initialValue: medicationName)
                
                self.dismissAction = dismissAction
            }
            var body: some View {
                NavigationView {
                    Form {
                        // Medication name
                        TextField("Name", text: $medicationName)
                        Stepper("Number of doses: \(numberOfDoses)", value: $numberOfDoses, in: 1...20)
                        // Frequency
                        Picker("Frequency", selection: $selectedFrequency) {
                            ForEach(MedicationFrequency.allCases) { frequency in
                                Text(frequency.rawValue)
                            }
                        }
                        // Date
                        DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                        
                        // Time
                        DatePicker("Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        
                        // Reminders
                        Toggle("Reminders", isOn: $remindersEnabled) .navigationTitle("New Medication")
                            .navigationBarTitleDisplayMode(.inline)
                    }}
               
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
                        medicationName: medicationName,
                       numberOfDoses: numberOfDoses,
                        selectedFrequency: selectedFrequency.rawValue,
                        selectedDate: selectedDate
                    )
                    
                    if let index = pills.firstIndex(where: { $0.medicationName == newPill.medicationName }) {
                        pills[index] = newPill
                    } else {
                        pills.append(newPill)
                    }
                    dismissAction()
                }) {
                    Text("save")
                }
            }
        }
        // end add ________________________________________
   
    
        // start PillDetail_____________________________________
        struct PillDetail: View {
            
            var pill: Pill
            @State private var isChecked = false
            @State private var pills: [Pill] = []
            var body: some View {
                ScrollView {
                    HStack{
                        
                        VStack(alignment: .center) {
                            
                            
                            Text( "pill name: ")
                                .font(.headline)
                                .foregroundColor(Color.our)
                            Text(pill.medicationName)
                                .padding(.bottom, 20.0)
                            Text("number Of Doses: ") .font(.headline)
                                .foregroundColor(Color.our)
                            Text("\(pill.numberOfDoses)")
                                .padding(.bottom, 20.0)
                            Text("starting date:  ").font(.headline)
                                .foregroundColor(Color.our)
                            Text("\(pill.selectedDate.formatted())")
                                .padding(.bottom, 20.0)
                            Text("frequency: ").font(.headline)
                                .foregroundColor(Color.our)
                            Text(pill.selectedFrequency)
                            HStack{
                                Toggle(isOn: $isChecked) {
                                    Text("")
                                }
                                .toggleStyle(CheckboxToggleStyle())
                            }
                            
                        }
                        }}}}
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
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(lineWidth: 2)
                .frame(width: 25, height: 25)
            configuration.label
                .font(.system(size: 15))
        }
        .padding()
    }
}
// end ContentView _____________________________________

#Preview {
    ContentView()
       
}
