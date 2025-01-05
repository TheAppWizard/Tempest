//
//  NoiseView.swift
//  Tempest
//
//  Created by Shreyas Vilaschandra Bhike on 04/01/25.
//

import SwiftUI


struct NoiseView: View {
    let dominantColor: Color
    let baseColor: Color
    var body: some View {
        ZStack{
            ZStack{
                Circle().foregroundStyle(dominantColor)
                    .offset(x:0 ,y:0)
                Circle().foregroundStyle(dominantColor)
                    .offset(x:200,y:0)
                Circle().foregroundStyle(baseColor)
                    .offset(x:-200 , y:0)
               }
                .blur(radius: 100)
            
            NoiseViewGenerator(noiseOpacity: 0.5)
        }
       
    }
}

struct NoiseViewGenerator: View {
    let noiseOpacity: Double
    
    var body: some View {
        Canvas { context, size in
                       _ = NoiseGenerator()
                       for x in stride(from: 0, to: size.width, by: 2) {
                           for y in stride(from: 0, to: size.height, by: 2) {
                               let intensity = Double.random(in: 0...1)
                               let color = Color(white: intensity)
                               context.fill(Path(ellipseIn: CGRect(x: x, y: y, width: 0.8, height: 0.8)), with: .color(color))
                           }
                       }
                   }
                    .opacity(noiseOpacity)
                    .blendMode(.overlay)
                    .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    NoiseView(
        dominantColor: Color.blue,
        baseColor: Color.pink.opacity(0.3)
    )
}


struct NoiseGenerator {
    func generateNoise() -> [Double] {
        (0..<1_000_00).map { _ in Double.random(in: 0...1) }
    }
}
