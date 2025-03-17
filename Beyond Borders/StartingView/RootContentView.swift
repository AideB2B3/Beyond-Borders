import SwiftUI

// La vera root view dell'app che può essere resettata
struct RootContentView: View {
    @EnvironmentObject var navigationState: NavigationState
    @State private var resetTrigger = UUID()
    
    var body: some View {
        ContentView(
            numParticipants: 2,
            participants: ["", ""],
            numRounds: 1,
            turnDuration: 60,
            onStart: {},
            onHome: {}
        )
        .id(resetTrigger)
        .onChange(of: navigationState.resetToRoot) { onChangeValue, needsReset in
            if needsReset {
                // Resettiamo l'intero stato e lo stack di navigazione
                resetTrigger = UUID()
                navigationState.resetToRoot = false
            }
        }
    }
}

#Preview {
    RootContentView()
}
