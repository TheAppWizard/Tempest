//
//  LottieView.swift
//  Tempest
//
//  Created by Shreyas Vilaschandra Bhike on 05/01/25.
//

import Foundation
import SwiftUI
import Lottie


struct LottieAnimate: View {
    var body: some View {
        ZStack {
            LottieView(animationName: "clouds", loopMode: .loop)
                .frame(width: 500, height: 500)
                .blur(radius: 5)
        }
    }
}

#Preview {
    LottieAnimate()
}





struct LottieView: UIViewRepresentable {
    var animationName: String
    var loopMode: LottieLoopMode = .playOnce
    
    private let animationView = LottieAnimationView()

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        animationView.animation = LottieAnimation.named(animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        view.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
       
    }
}
