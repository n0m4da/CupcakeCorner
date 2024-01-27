//
//  loadImageFromServer.swift
//  CupcakeCorner
//
//  Created by Luis Rivera on 26/01/24.
//

import SwiftUI


//MARK: - struct

//MARK: - view
struct loadImageFromServer: View {
    //MARK: - Properties
    var body: some View {
        // if you know the scale
        //AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
        
        
        // resizable not work
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")){ image in
//      
//            
//            //first time not work properly image.image?.resizable
//            image.resizable()
//                .scaledToFill()
//            
//        } placeholder: {
//            ProgressView()
//        }
//        
        
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")){ phase in
            
            
            //first time not work properly image.image?.resizable
            
            if let image = phase.image {
                
                
                image.resizable()
                    .scaledToFill()
                
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
        }.frame(width: 200, height: 200)
     
    }
}

#Preview {
    loadImageFromServer()
}
