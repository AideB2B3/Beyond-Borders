import SwiftUI

struct SettingsView: View {
    
    @State var numParticipants: Int
    @State var participants: [String]
    @State var numRounds: Int
    @State var turnDuration: Int
    var onStart: () -> Void
    var onHome: () -> Void
    
    @State private var keyboardIsVisible = false
    
    @State private var isCountryPresented = false
    
    var isStartEnabled: Bool {
        let validNames = participants.filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        return validNames.count >= 2 && validNames.count == numParticipants
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.beigeBack)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    VStack(spacing: 35) {
                        Text("Match Settings")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color(.colorWritten))
                        
                        Spacer()
                        
                        Form {
                            Stepper("Total People: \(numParticipants)", value: $numParticipants, in: 2...8)
                                .onChange(of: numParticipants) {
                                    if numParticipants > participants.count {
                                        participants.append(contentsOf: Array(repeating: "", count: numParticipants - participants.count))
                                    } else {
                                        participants = Array(participants.prefix(numParticipants))
                                    }
                                }
                                .listRowBackground(Color(.beigeBack))
                                .foregroundColor(Color(.colorWritten))
                            
                            ForEach(participants.indices, id: \.self) { i in
                                TextField("Insert Name \(i + 1)", text: $participants[i])
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .foregroundColor(Color(.colorWritten))
                                    .listRowBackground(Color(.beigeBack))
                            }
                            
                            //                            Stepper("Rounds: \(numRounds)", value: $numRounds, in: 1...50, step: 1)
                            //                                .listRowBackground(Color(red: 1.0, green: 0.945, blue: 0.816))
                            //                                .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                            
                            Stepper("Turn Duration: \(turnDuration) sec", value: $turnDuration, in: 30...600, step: 30)
                                .listRowBackground(Color(.beigeBack))
                                .foregroundColor(Color(.colorWritten))
                        }
                        .scrollContentBackground(.hidden)
                        .background(Color(.beigeBack))
                    }
                    
                    Button(action: {
                        print("Settings Button tapped")
                        isCountryPresented = true
                        
                    }) {
                        Text("Next")
                            .font(.title)
                            .padding()
                            .bold()
                            .frame(width: 130, height: 70)
                            .background(Color(.colorWritten))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    .disabled(!isStartEnabled)
                    .opacity(isStartEnabled ? 1 : 0.7)
                    .padding(.bottom, 30)
                    .animation(.easeInOut(duration: 0.2), value: isStartEnabled)
                    .opacity(keyboardIsVisible ? 0 : 1)
                    
                    .fullScreenCover(isPresented: $isCountryPresented){
                        CountryView(numParticipants: $numParticipants, participants: $participants, numRounds: $numRounds, turnDuration: $turnDuration, onHome: onHome)
                    }
                }
                .padding()
            }
            .onAppear {
                numParticipants = 2
                participants = ["", ""]
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
                    keyboardIsVisible = true
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                    keyboardIsVisible = false
                }
            }
        }
        .preferredColorScheme(.light)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            numParticipants: 3,
            participants: ["Alice", "Bob", "Charlie"],
            numRounds: 1,
            turnDuration: 60,
            onStart: {},
            onHome: {}
        )
    }
}
