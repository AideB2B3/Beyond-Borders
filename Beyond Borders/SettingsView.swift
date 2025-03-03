import SwiftUI

struct SettingsView: View {
    
    @State var numParticipants: Int
    @State var participants: [String]
    @State var numRounds: Int
    @State var turnDuration: Int
    var onStart: () -> Void
    
    // Per gestire la visibilità della tastiera
    @State private var keyboardIsVisible = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 1.0, green: 0.945, blue: 0.816)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    VStack(spacing: 35) {
                        Text("Match Settings")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                        
                        Spacer()
                        
                        Form {
                            Stepper("Total People: \(numParticipants)", value: $numParticipants, in: 0...8)
                                .onChange(of: numParticipants) {
                                    if numParticipants > participants.count {
                                        participants.append(contentsOf: Array(repeating: "", count: numParticipants - participants.count))
                                    } else {
                                        participants = Array(participants.prefix(numParticipants))
                                    }
                                }
                                .listRowBackground(Color(red: 1.0, green: 0.945, blue: 0.816))

                            ForEach(participants.indices, id: \.self) { i in
                                TextField("Insert Name \(i + 1)", text: $participants[i])
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .listRowBackground(Color(red: 1.0, green: 0.945, blue: 0.816))
                            }

                            Stepper("Rounds: \(numRounds)", value: $numRounds, in: 1...10)
                                .listRowBackground(Color(red: 1.0, green: 0.945, blue: 0.816))
                            
                            Stepper("Turn Duration: \(turnDuration) sec", value: $turnDuration, in: 10...600, step: 10)
                                .listRowBackground(Color(red: 1.0, green: 0.945, blue: 0.816))
                        }
                        .scrollContentBackground(.hidden)
                        .background(Color(red: 1.0, green: 0.945, blue: 0.816))
                    }
                    
                    NavigationLink(destination: CategoriesView(numParticipants: $numParticipants, participants: $participants, numRounds: $numRounds, turnDuration: $turnDuration, onHome: onStart)) {
                        Text("Start")
                            .font(.title3)
                            .padding()
                            .bold()
                            .frame(maxWidth: 150)
                            .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    .padding(.bottom, 30)
                    .opacity(keyboardIsVisible ? 0 : 1) // Nasconde il pulsante quando la tastiera è visibile
                }
                .padding()
            }
            .onAppear {
                numParticipants = 0
                participants = []
                
                // Registra notifiche per la tastiera
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
                    keyboardIsVisible = true
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                    keyboardIsVisible = false
                }
            }
        } //End NavigationStack
        .tint(Color(red: 0.176, green: 0.188, blue: 0.278))
        .navigationBarBackButtonHidden(true) // leva il tasto back
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            numParticipants: 3,
            participants: ["Alice", "Bob", "Charlie"],
            numRounds: 3,
            turnDuration: 60,
            onStart: {}
        )
    }
}
