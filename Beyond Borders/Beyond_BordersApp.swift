import SwiftUI

@main
struct BBApp: App {
    @State private var numParticipants = 3
    @State private var participants = ["Alice", "Bob", "Charlie"]
    @State private var numRounds = 3
    @State private var turnDuration = 60

    var body: some Scene {
        WindowGroup {
            ContentView(
                numParticipants: numParticipants,
                participants: participants,
                numRounds: numRounds,
                turnDuration: turnDuration,
                onStart: {
                    print("Discussion Started with \(numParticipants) participants")
                }
            )
        }
    }
}
