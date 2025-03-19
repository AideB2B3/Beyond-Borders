import SwiftUI

// Wrapper View che contiene tutta l'app
struct AppContainerView: View {
    
    @StateObject private var navigationState = NavigationState()
    
    var body: some View {
        RootContentView()
            .environmentObject(navigationState)
    }
}

#Preview {
    AppContainerView()
}
