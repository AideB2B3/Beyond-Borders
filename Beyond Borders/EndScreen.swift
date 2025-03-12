import SwiftUI

struct EndScreen: View {
    
    var onRestart: () -> Void
    var onHome: () -> Void
    
    @State private var isContentPresented = false
    @State private var isCountryPresented = false
    
    @State private var numParticipants: Int = 2
    @State private var participants: [String] = [" ", " "]
    @State private var numRounds: Int = 1
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
                        .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
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
                                .font(.title3)
                                .bold()
                        }
                        .background(Color.clear)
                        .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 50))
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }
                
                HStack {
                    
                    Button(action: {
                        resetGameToCountry()
                        isCountryPresented = true
                    }){
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
                    .fullScreenCover(isPresented: $isCountryPresented) {
                        CountryView(
                            numParticipants: $numParticipants,
                            participants: $participants,
                            numRounds: $numRounds,
                            turnDuration: $turnDuration,
                            onHome: {
                                onHome()
                            }
                        )
                    }
                    
                    Button(action: {
                        resetGameToContent()
                        isContentPresented = true
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
                    .fullScreenCover(isPresented: $isContentPresented) {
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
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 40)
        }
    }
    
    private func resetGameToContent() {
        numParticipants = 0
        participants = []
//        numRounds = 1
        turnDuration = 60
    }
    
    private func resetGameToCountry() {
        numParticipants = 2
        participants = ["", ""]
        numRounds = 3
        turnDuration = 60
    }

}

//struct EndScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        EndScreen(
//            onRestart: {},
//            onHome: {},
//            responses: [
//                (name: "Alice", answer: "Yes"),
//                (name: "Bob", answer: "No"),
//                (name: "Charlie", answer: "Yes")
////                (name: "Fratm", answer: "Yes"),
////                (name: "Brodm", answer: "No"),
////                (name: "Atm", answer: "No"),
////                (name: "Friariè", answer: "Yes"),
////                (name: "Fratè", answer: "Yes"),
////                (name: "Fratimo", answer: "No"),
////                (name: "Ciro", answer: "Yes")
//            ]
//        )
//    }
//}

