import SwiftUI

struct OnBoardingView: View {
    @Binding var isPresented: Bool
    @State private var currentImageIndex = 0
    @State private var timer: Timer?
    
//    let images = ["onboarding1", "onboarding2", "onboarding3", "onboarding4"]
    let images = ["1", "2", "3", "4"]

    var body: some View {
        ZStack {
            Color(.beigeBack)
                .ignoresSafeArea()
            
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

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPreviewWrapper()
    }
}

struct OnBoardingPreviewWrapper: View {
    @State private var isPresented = true
    
    var body: some View {
        if isPresented {
            OnBoardingView(isPresented: $isPresented)
        } else {
            Text("Onboarding completato!")
        }
    }
}
