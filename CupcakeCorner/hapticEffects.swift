//
//  hapticEffects.swift
//  CupcakeCorner
//
//  Created by Luis Rivera on 29/01/24.
//
import CoreHaptics
import SwiftUI

struct hapticEffects: View {
    //MARK: - PROPERTIES
    @Environment (\.dismiss) private var presentationmode
    @State private var counter = 0
    
    @State private var engine: CHHapticEngine?
    
    //MARK: - BODY
    var body: some View {
        NavigationStack {
            Button("tap count: \(counter)"){
                counter += 1
            }
            // low costumize options
            .sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: counter)
            
            Button("HAPTIC", action: complexSuccess)
                .onAppear(perform: prepareHaptics)
               
            
            .toolbar{
                Button("close")
                {
                    presentationmode.callAsFunction()
                }
            }
        }
        
        
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            
            try engine?.start()
        }catch{
            print("ther was an error creating the engine haptics:\(error.localizedDescription) ")
        }
    }
    
    func complexSuccess (){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var evets = [CHHapticEvent]()
        for i in stride(from: 0, to: 1, by: 0.1){
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float( i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            
            evets.append(event)
        }
        
        
        for i in stride(from: 0, to: 1, by: 0.1){
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            
            evets.append(event)
        }
        do {
            let pattern = try CHHapticPattern(events: evets, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        }catch{
            print("failet haptic\(error.localizedDescription)")
        }
    }
}

#Preview {
    hapticEffects()
}
