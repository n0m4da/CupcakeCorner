//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Luis Rivera on 26/01/24.
//

import SwiftUI




struct ContentView: View {
    //MARK: - PROPERTIES
    
    @State private var order = Order()
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("select your cake type", selection: $order.type){
                        ForEach(Order.types.indices, id:  \.self){
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity)
                }
                
                Section{
                    Toggle("Any special request?", isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled{
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                    
                
                }
                
                Section{
                    NavigationLink("Delivery details") {
                        AddressView(order: order)
                    }
                }
                .navigationTitle("Cupcake Corner")
            }
        }
    }
    
    
}

#Preview {
    ContentView()
}
