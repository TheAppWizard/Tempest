//
//  ContentView.swift
//  Tempest
//
//  Created by Shreyas Vilaschandra Bhike on 04/01/25.
//

//  MARK: Instagram
//  TheAppWizard
//  MARK: theappwizard2408

import SwiftUI

struct ContentView: View {
    @State var splashScreen  = true

    var body: some View {
         ZStack{
            Group{
              if splashScreen { SplashScreen()}
              else{ MainScreen()}}
               .onAppear {
                  DispatchQueue
                       .main
                       .asyncAfter(deadline:
                        .now() + 3) {
                   splashScreen = false
                  }
                }
            }
        }
    }


#Preview {
    ContentView()
}

























