import SwiftUI

@main
struct EBP_DiabetesApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}

struct SplashView: View {
    @State private var showMain = false

    var body: some View {
        if showMain {
            ContentView()
        } else {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: "1e3a5f"), Color(hex: "2563eb")]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Text("🩺")
                        .font(.system(size: 72))
                    Text("Diabetes Risk Prediction")
                        .font(.title2.weight(.semibold))
                        .foregroundColor(.white)
                    Text("EBP Medical — Kyungwoon University")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))

                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .padding(.top, 30)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                    withAnimation { showMain = true }
                }
            }
        }
    }
}
