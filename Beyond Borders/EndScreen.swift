import SwiftUI

struct EndScreen: View {
    
    var onRestart: () -> Void
    var onHome: () -> Void
    
    @Binding var numParticipants: Int
    @Binding var participants: [String]
    @Binding var numRounds: Int
    @Binding var turnDuration: Int
    
    var responses: [(name: String, answer: String)]
    
    @Environment(\.presentationMode) var presentationMode
    @State private var isCountryPresented = false
    @State private var navigateToRoot = false
    
    var body: some View {
        
        ZStack {
            
            Color(.beigeBack)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                
                VStack {
                    Text("Responses")
                        .font(.custom("Atma-Bold", fixedSize: 25))
                        .foregroundColor(Color(.colorWritten))
                        .padding()
                    
                    List(responses, id: \.name) { response in
                        HStack {
                            Text("-  \(response.name )  said:")
                                .foregroundColor(Color(.colorWritten))
                                .font(.custom("Atma-Bold", fixedSize: 25))
                            Spacer()
                            Text(response.answer)
                                .foregroundColor(Color(.colorWritten))
                                .font(.custom("Atma-Bold", fixedSize: 25))
                        }
                        .background(Color.clear)
                        .listRowInsets(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 70))
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }
                
                HStack {
                    
                    Button(action: {
                        isCountryPresented = true
                    }){
                        Label("Match", systemImage: "arrow.clockwise")
                            .font(.custom("Atma-Bold", fixedSize: 25))
                            .padding()
                            .bold()
                            .frame(width: 150, height: 70)
                            .background(Color(.colorWritten))
                            .foregroundColor(.white)
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
                        // Dismissiamo tutte le presentazioni modali
                        // e torniamo alla ContentView iniziale
                        navigateToRoot = true
                    }) {
                        Label("Home", systemImage: "house")
                            .font(.custom("Atma-Bold", fixedSize: 25))
                            .padding()
                            .bold()
                            .frame(width: 150, height: 70)
                            .background(Color(.colorWritten))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 40)
        }
        .background(
            NavigationLink(
                destination: RootResetView(),
                isActive: $navigateToRoot,
                label: { EmptyView() }
            )
        )
    }
}

// Nuova view che serve solo per resettare la navigazione
struct RootResetView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var navigationState: NavigationState
    
    var body: some View {
        Color.clear
            .onAppear {
                // Segnaliamo che vogliamo tornare alla radice
                navigationState.resetToRoot = true
                // Dismetti questa view immediatamente
                self.presentation.wrappedValue.dismiss()
            }
    }
}

// Classe ObservableObject per gestire lo stato di navigazione globale
class NavigationState: ObservableObject {
    @Published var resetToRoot = false
}

struct EndScreen_Previews: PreviewProvider {
    static var previews: some View {
        EndScreen(
            onRestart: {},
            onHome: {},
            numParticipants: .constant(3),
            participants: .constant(["Alice", "Bob", "Charlie"]),
            numRounds: .constant(2),
            turnDuration: .constant(60),
            responses: [
                (name: "Alice", answer: "Yes"),
                (name: "Bob", answer: "Yes"),
                (name: "Charlie", answer: "No")
            ]
        )
    }
}
