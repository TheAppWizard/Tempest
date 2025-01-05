//
//  SplashScreen.swift
//  Tempest
//
//  Created by Shreyas Vilaschandra Bhike on 04/01/25.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "1f4068"),
                    Color(hex: "162447"),
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            
            
            VStack{
                Text("T E M P E S T")
                    .fontWeight(.light)
                    .font(.system(size: 32))
                    .foregroundStyle(.white)
                
                Spacer()
                    .frame(height: 50)
                CustomCircularLoader()
            }
           
        }
    }
}




struct CustomCircularLoader: View {
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 8)
            Circle()
                .trim(from: 0.0, to: 0.8)
                .stroke(Color.white, lineWidth: 8)
                .rotationEffect(
                    Angle(degrees: isAnimating ? 360 : 0))
                .animation(
                    Animation.linear(duration: 1)
                        .repeatForever(autoreverses: false),
                    value: isAnimating
                )
        }
        .frame(width: 60, height: 60)
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    SplashScreen()
}
