//
//  ContentView.swift
//  test2
//
//  Created by Carter Hawkins on 9/24/22.
//

import SwiftUI
import CoreMotion

let motionManager = CMMotionManager()


struct ContentView: View {
    @State private var colorChange = false
    var body: some View {
        VStack {
            Circle()
                .foregroundColor(colorChange ? .green : .blue)
                .frame(width: 200, height: 200)
        }
        .padding()
        .onAppear() {
            motionManager.gyroUpdateInterval = 0.1
            
            motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, error) in
                if let myData = data {
                    if myData.rotationRate.y > 8 {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            colorChange = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
                                
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    colorChange = false
                                }
                            })
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
