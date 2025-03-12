import SwiftUI

struct OnBoardingView: View {
    @Binding var isPresented: Bool
    @State private var currentImageIndex = 0
    @State private var timer: Timer?
    
    let images = ["onboarding1", "onboarding2", "onboarding3", "onboarding4"]
    
    var body: some View {
        ZStack {
            Image(images[currentImageIndex])
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            Color.black.opacity(0.001)
                .ignoresSafeArea()
                .onTapGesture {
                    dismissOnboarding()
                }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.75, repeats: true) { _ in
            if currentImageIndex < images.count - 1 {
                currentImageIndex += 1
            } else {
                dismissOnboarding()
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func dismissOnboarding() {
        stopTimer()
        isPresented = false
    }
}


//#Preview {
//    OnBoardingView(isPresented: isPresented)
//}
