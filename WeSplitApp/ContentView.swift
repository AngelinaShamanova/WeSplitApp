//
//  ContentView.swift
//  WeSplitApp
//
//  Created by Ангелина Шаманова on 13.11.22..
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    
    @FocusState private var amountIsFocused: Bool
    
    private let tipPercentages = [10, 15, 20, 25, 0]
    
    private var tipSelection: Double{
        Double(tipPercentage)
    }
    private var tipValue: Double {
        checkAmount / 100 * tipSelection
    }
    private var grandTotal: Double {
        checkAmount + tipValue
    }
    
    private var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    private var currencyFormat: FloatingPointFormatStyle<Double>.Currency {
        return FloatingPointFormatStyle<Double>.Currency.currency(code: Locale.current.currencyCode ?? "USD")
    }
    
    private var tipErrorText: String {
        return tipPercentage >= 10
        ? ""
        : "The tip amount is less than 10 percent!"
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyFormat)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Check amount")
                }
                Section {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0...100, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: currencyFormat.currencyCode))
                } header: {
                    Text("Total amount")
                } footer: {
                    Text(tipErrorText)
                        .foregroundColor(.red)
                }
                Section {
                    Text(grandTotal, format: .currency(code: currencyFormat.currencyCode))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
