//
//  splash.swift
//  pillbell
//
//  Created by Leen Almejarri on 11/06/1445 AH.
//

import Foundation
import SwiftUI

struct splashView: View {
    
    @State private var logoScale: CGFloat = 0.3
    @State private var logoOffset: CGSize = .zero
    @State private var isLogoVisible = false
    @State private var nextPageIsActive = false
    
    var body: some View {
        ZStack {
            Image("Image")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            Image("logo1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(logoScale)
                .offset(logoOffset)
                .scaledToFit()
                .frame(width: 230)
                .padding(.leading, 0)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        isLogoVisible = true
                        logoScale = 1.0
                        logoOffset = CGSize(width: 0, height: -30)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        nextPageIsActive = true
                    }
                }
                .opacity(isLogoVisible ? 1 : 0)
        }
        //link here
        .fullScreenCover(isPresented: $nextPageIsActive, content: {
            NextPage()
        })
    }
}

struct NextPage: View {
    var body: some View {
        ContentView()
    }
}

#Preview {
    splashView()
}
