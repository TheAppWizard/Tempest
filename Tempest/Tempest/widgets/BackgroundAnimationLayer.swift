//
//  BackgroundAnimationLayer.swift
//  Tempest
//
//  Created by Shreyas Vilaschandra Bhike on 05/01/25.
//

import SwiftUI

struct BackgroundAnimationLayer: View {
    var body: some View {
        ZStack{
            VStack{
                LottieView(animationName: "clouds", loopMode: .loop)
                    .frame(width:  .infinity, height: 400)
                    .blur(radius: 5)
                    .offset(y:-100)
                Spacer()
                
                
                ZStack{
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .offset(y:200)
                    
                    LottieView(animationName: "windmill", loopMode: .loop)
                        .frame(width: 500, height: 400)
                        .offset(y:-140)
                    
                    
                    Image("home")
                        .resizable()
                        .frame(width: 80,height: 80)
                        .offset(x:-80,y:-15)
                }
            }
        }
    }
}

#Preview {
    BackgroundAnimationLayer()
}
