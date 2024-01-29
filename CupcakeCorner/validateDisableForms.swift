//
//  validateDisableForms.swift
//  CupcakeCorner
//
//  Created by Luis Rivera on 28/01/24.
//

import SwiftUI

struct validateDisableForms: View {
    //MARK: - properties
    @State private var username = ""
    @State private var email = ""
    
    var diableForm: Bool{
        username.count < 5 || email.count < 5
    }
    
    //MARK: - BODY
    var body: some View {
        Form{
            Section{
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section{
                Button("Create account"){
                    print("creating accoun")
                }
            }
            .disabled(diableForm)
        }
    }
}

#Preview {
    validateDisableForms()
}
