//
//  codable.swift
//  CupcakeCorner
//
//  Created by Luis Rivera on 30/01/24.
//

import SwiftUI

@Observable
class User: Codable{
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    
    var name = "Taylor"
}


struct codable: View {
    //MARK: - PROPERTIES
    
    //MARK: - BODY
    var body: some View {
        Button("Encode taylor" , action: encodeTaylor)
    }
    
    func encodeTaylor() {
        let data = try! JSONEncoder().encode(User())
        
        let str = String(decoding: data, as: UTF8.self)
        
        print(str)
    }
}

#Preview {
    codable()
}
