//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Luis Rivera on 26/01/24.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
    
    
}

struct Result: Codable {
        var trackId: Int
        var trackName: String
        var collectionName: String
}


struct ContentView: View {
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId ){ item in
            VStack(alignment: .leading){
                Text(item.trackName)
                    .font(.headline)
                
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
     
    }
    
    
    func loadData() async {
        
   
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
     
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data)
            {
                print(data)
                results = decodedResponse.results
            
            }
            
        } catch {
            print("invalid data")
        }
    }
}

#Preview {
    ContentView()
}
