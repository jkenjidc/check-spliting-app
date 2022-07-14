//
//  ContentView.swift
//  WeSplit
//
//  Created by Justine Kenji Dela Cruz on 7/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    var currencyType: FloatingPointFormatStyle<Double>.Currency{
        return .currency(code: Locale.current.currencyCode ?? "USD")
    }
    let tipPercentages = [0,10,15,20,25]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var totalAmount: Double{
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format:
                            currencyType)
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                Section{
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(0..<101){
                            Text($0, format: .percent)
                        }
                    }
                }header: {
                    Text("How much tip do you want?")
                }
                Section{
                    Text(totalAmount, format: currencyType)
                }header: {
                    Text("Total amount")
                }
                Section{
                    Text(totalPerPerson, format: currencyType)
                }header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("weSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
