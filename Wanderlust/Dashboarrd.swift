import SwiftUI

struct Dashboard: View {
    @Binding var CurrentTab: Tabs
    var body: some View {
        ZStack {
            HeavyFogBackground()
        VStack {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 5)
                    .frame(maxWidth: .infinity, maxHeight: 400)
                    .ignoresSafeArea(edges: .top)
                    .padding(.horizontal, 5)
            }
            Button {
                CurrentTab = .Game
            } label: {
                Text("Game")
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .padding(.horizontal, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.black, lineWidth: 1))
            }
            Button {
                CurrentTab = .Passport
            } label: {
                Text("Passport")
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .padding(.horizontal, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.black, lineWidth: 1))
            }
            Button {
                CurrentTab = .Trivia
            } label: {
                Text("Trivia")
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .padding(.horizontal, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.black, lineWidth: 1))
            }
        }
    }
    }
}

#Preview {
    Dashboard(CurrentTab: .constant(.Dashboard))
}

struct HeavyFogBackground: View {
    @State private var drift = false
    
    var body: some View {
        ZStack {
            // 1. Matte Off-Black Base
            Color(red: 0.04, green: 0.05, blue: 0.07)
                .ignoresSafeArea()
            
            // 2. Volumetric Fog Clouds
            GeometryReader { proxy in
                let size = proxy.size
                
                ZStack {
                    // Base Ambient Mist
                    RadialGradient(
                        colors: [Color(white: 0.55).opacity(0.35), .clear],
                        center: .center,
                        startRadius: 20,
                        endRadius: size.width * 0.7
                    )
                    .frame(width: size.width * 1.4, height: size.width * 1.4)
                    .blur(radius: 90)
                    .offset(x: drift ? -80 : 40, y: drift ? -100 : -20)
                    
                    // Dense Cool Cloud
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [Color(red: 0.4, green: 0.45, blue: 0.55).opacity(0.40), .clear],
                                center: .center,
                                startRadius: 0,
                                endRadius: 220
                            )
                        )
                        .frame(width: 450, height: 450)
                        .blur(radius: 70)
                        .blendMode(.screen)
                        .offset(x: drift ? 120 : -60, y: drift ? 80 : 200)
                    
                    // Dense Warm Smoke Accent
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [Color(white: 0.75).opacity(0.30), .clear],
                                center: .center,
                                startRadius: 0,
                                endRadius: 250
                            )
                        )
                        .frame(width: 500, height: 500)
                        .blur(radius: 80)
                        .blendMode(.screen)
                        .offset(x: drift ? -100 : 80, y: drift ? -150 : 50)
                    
                    // Low-Hanging Ground Fog
                    Ellipse()
                        .fill(
                            LinearGradient(
                                colors: [Color(white: 0.6).opacity(0.45), .clear],
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                        .frame(width: size.width * 1.5, height: 350)
                        .blur(radius: 60)
                        .blendMode(.plusLighter)
                        .offset(y: size.height / 2 - 100)
                }
                .frame(width: size.width, height: size.height)
            }
            .ignoresSafeArea()
        }
        .onAppear {
            withAnimation(
                .easeInOut(duration: 12.0)
                .repeatForever(autoreverses: true)
            ) {
                drift.toggle()
            }
        }
    }
}
