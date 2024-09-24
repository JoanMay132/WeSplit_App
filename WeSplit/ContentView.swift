//
//  ContentView.swift
//  WeSplit
//
//  Created by Joan May on 12/09/24.
//

import SwiftUI

struct ContentView: View {
    
    let students: [String] = ["Faride", "Joan", "Carlos", "Leo"]

    @State private var studentName : String = "Faride"
    @State private var name: String = ""
    
    // Reading text from the user with text field
    @State private var checkAmount = 0.0
    @State private var numberOfPeople: Int = 0
    @State private var tipPercentage: Int = 20
    @FocusState private var amountIsFocused : Bool
    
    let tipPercentages: [Int] = [0,5,10,15,20]
    
    var tipValue: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = (checkAmount / 100) * tipSelection
        return tipValue
        
    }
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let totalAmount = checkAmount + tipValue
        let amountPerPerson = totalAmount / peopleCount
        return amountPerPerson
    }
    
    var AmountAndTip: Double {
        return checkAmount + tipValue
    }

    var body: some View {
        NavigationStack {
            Form {
                Picker("Select your student: ", selection: $studentName){
                    ForEach(students, id: \.self) { studentName in
                        Text(studentName)
                    }
                }
                // Just printing Hello
                Section{
                    Text("Hello World! How are you?")
                }
                // A section to type my name
                Section ("Introduce your name below 👇🏻 ") {
                    TextField("Enter your name here: ", text: $name)
                    Text("Your name is: \(name)")
                }
             
                
                Section("Total amount without tip"){ // A section to type an amount and select number of people
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.autoupdatingCurrent.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                        
                    }
                    .pickerStyle(.navigationLink)// Defining the pickerStyle
                }
                
                // Section for adding a segmented control for tip percentages
                Section("How much do you want to tip?"){
                    Picker("Select your tip percentage", selection: $tipPercentage){
                        ForEach(0..<101) { tipPercentage in
                            Text(tipPercentage, format: .percent)
                            
                        }
                    }
                    .pickerStyle(.wheel).frame(height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)                }
                // A section to show the total amount for the check + tip
                Section ("Total amount for the check") {
                    Text(AmountAndTip, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        // Conditional modifier
                        .foregroundStyle(tipPercentage == 0 ? .red : .primary)
                }
                // Amount per person
                Section ("Amount per person: "){ //Printing the typed amount
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                
                if amountIsFocused {
                    Button("Done"){
                        amountIsFocused = false
                    }
                    
                }
                
            }
            
            
        }
        
    }
}

#Preview {
    ContentView()
}
