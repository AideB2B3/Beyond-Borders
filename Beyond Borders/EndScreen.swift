import SwiftUI

struct EndScreen: View {
    
    var onRestart: () -> Void
    var onHome: () -> Void
    
    @State private var isSettingsPresented = false
    
    @State private var numParticipants: Int = 2
    @State private var participants: [String] = ["", ""]
    @State private var numRounds: Int = 3
    @State private var turnDuration: Int = 60
    
    var responses: [(name: String, answer: String)]
    
    var body: some View {
        
        ZStack {
            Color(red: 1.0, green: 0.945, blue: 0.816)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                
                VStack {
                    Text("Responses")
                        .font(.largeTitle)
                        .bold()
                        .padding()

                    List(responses, id: \.name) { response in
                        HStack {
                            Text(response.name)
                                .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                                .font(.title2)
                                .bold()
                            Spacer()
                            Text(response.answer)
                                .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                                .bold()
                        }
                        .padding()
                        .background(Color.clear) // Assicurati che ogni cella abbia sfondo trasparente
                        .listRowBackground(Color.clear) // Imposta lo sfondo della riga a trasparente
                    }
                    .listStyle(PlainListStyle()) // Rimuove lo stile predefinito della lista
                    .scrollContentBackground(.hidden) // Nasconde il background della lista
                    .background(Color.clear) // Rende lo sfondo trasparente

                }
                
                HStack {
                    
                    Button(action: onRestart) {
                        Label("Round", systemImage: "arrow.clockwise")
                            .font(.title3)
                            .padding()
                            .bold()
                            .frame(maxWidth: 150)
                            .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .foregroundColor(Color(red: 1.0, green: 0.945, blue: 0.816))
                            .cornerRadius(30)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        isSettingsPresented = true
                    }) {
                        Label("Home", systemImage: "house")
                            .font(.title3)
                            .padding()
                            .bold()
                            .frame(maxWidth: 150)
                            .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .foregroundColor(Color(red: 1.0, green: 0.945, blue: 0.816))
                            .cornerRadius(30)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 40)
            .fullScreenCover(isPresented: $isSettingsPresented) {
                ContentView(
                    numParticipants: numParticipants,
                    participants: participants,
                    numRounds: numRounds,
                    turnDuration: turnDuration,
                    onStart: {
                        
                    },
                    onHome: {
                        onHome()
                    }
                )
            }
        }
    }
}

struct EndScreen_Previews: PreviewProvider {
    static var previews: some View {
        EndScreen(
            onRestart: {},
            onHome: {},
            responses: [
                (name: "Alice", answer: "Yes"),
                (name: "Bob", answer: "No"),
                (name: "Charlie", answer: "Yes")
            ]
        )
    }
}
