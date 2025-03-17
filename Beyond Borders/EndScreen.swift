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
                        .font(.largeTitle)
                        .foregroundColor(Color(.colorWritten))
                        .bold()
                        .padding()
                    
                    List(responses, id: \.name) { response in
                        HStack {
                            Text(response.name)
                                .foregroundColor(Color(.colorWritten))
                                .font(.title2)
                                .bold()
                            Spacer()
                            Text(response.answer)
                                .foregroundColor(Color(.colorWritten))
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
                        isCountryPresented = true
                    }){
                        Label("Round", systemImage: "arrow.clockwise")
                            .font(.title3)
                            .padding()
                            .bold()
                            .frame(maxWidth: 150)
                            .background(Color(.colorWritten))
                            .foregroundColor(Color(.white))
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
                            .font(.title3)
                            .padding()
                            .bold()
                            .frame(maxWidth: 150)
                            .background(Color(.colorWritten))
                            .foregroundColor(Color(.white))
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
