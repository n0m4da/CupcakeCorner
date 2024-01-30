//
//  loadJsonFromInternet.swift
//  CupcakeCorner
//
//  Created by Luis Rivera on 30/01/24.
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

struct loadJsonFromInternet: View {
    @State private var results = [Result]()
    @State private var showDialog : Bool = false
    var body: some View {
        NavigationStack {
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
            .toolbar{
                Button("Modal"){
                    showDialog.toggle()
                }
            }
        }.sheet(isPresented: $showDialog){
            hapticEffects()
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
    loadJsonFromInternet()
}
