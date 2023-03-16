//
//  ContentView.swift
//  Animation
//
//  Created by Seika Hirori on 3/6/23.
//

import SwiftUI

struct ContentView: View {
    @State private var hello_World: String = "Hello World :333"
    
    
    var body: some View {
        part_1_implementation(hello_World: $hello_World)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct part_1_implementation: View {
    @Binding var hello_World:String
    @State private var animationAmount: Double = 1.0
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(hello_World)
            
            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(50)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
            .blur(radius: (animationAmount - 1) * 3)
            .animation(
                .easeInOut(duration: 2)
            .delay(0.5),
               value: animationAmount
            )
            .onChange(of: animationAmount) { _ in
                debug_print_animation_state(animationAmount: animationAmount)
            }
            
            
        }
        .padding()
    }
    
    func debug_print_animation_state(animationAmount: Double) {
        print("Animation amount: \(animationAmount)")
    }

}
// test

struct part_2_implementation: View {
    @Binding var hello_World:String
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(hello_World)
        }
        .padding()
    }
    
}

// RFER #1
extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
