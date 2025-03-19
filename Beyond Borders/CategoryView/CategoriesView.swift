import SwiftUI

struct CategoriesView: View {
    @Binding var numParticipants: Int
    @Binding var participants: [String]
    @Binding var numRounds: Int
    @Binding var turnDuration: Int
    var onHome: () -> Void
    
    @State private var isLanguagePresented = false
    @State private var isFoodPresented = false
    @State private var isCulturePresented = false
    @State private var isOffensivePresented = false

    @State private var isJump = false
    
    let selectedCountry: Country
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let corners : CGFloat = 25
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color(.beigeBack)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Choose the Category!\n")
                        .font(.custom("Atma", fixedSize: 35))
                        .bold()
                        .foregroundColor(Color(.colorWritten))
                        .padding(.top, 40)
                    
                    Image("Alien_Category")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 220, height: 220)
                        .offset(y: isJump ? -8 : 8)
                        .animation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: isJump)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                isJump = true
                            }
                        }
                    
                    LazyVGrid(columns: columns) {
                        
                        Button(action: {
                            isLanguagePresented = true
                            
                        }) {
                            Text("Language")
                                .font(.custom("Atma", fixedSize: 25))
                                .bold()
                                .frame(width: 160, height: 160)
                                .background(Color(.white.opacity(0.5)))
                                .foregroundColor(Color(.colorWritten))
                                .cornerRadius(corners)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: corners)
                                .stroke(Color(.colorLanguage), lineWidth: 5)
                        )
                        .fullScreenCover(isPresented: $isLanguagePresented){
                            LanguageView(numParticipants: $numParticipants, participants: $participants, numRounds: $numRounds, turnDuration: $turnDuration, onHome: onHome, selectedCountry : selectedCountry)
                        }
                        
                        Button(action: {
                            isFoodPresented = true
                            
                        }) {
                            Text("Food")
                                .font(.custom("Atma", fixedSize: 25))
                                .bold()
                                .frame(width: 160, height: 160)
                                .background(Color(.white.opacity(0.5)))
                                .foregroundColor(Color(.colorWritten))
                                .cornerRadius(corners)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: corners)
                                .stroke(Color(.colorFood), lineWidth: 5)
                        )
                        .fullScreenCover(isPresented: $isFoodPresented){
                            FoodView(numParticipants: $numParticipants, participants: $participants, numRounds: $numRounds, turnDuration: $turnDuration, onHome: onHome, selectedCountry : selectedCountry)
                        }
                        
                        Button(action: {
                            isCulturePresented = true
                            
                        }) {
                            Text("Culture")
                                .font(.custom("Atma", fixedSize: 25))
                                .bold()
                                .frame(width: 160, height: 160)
                                .background(Color(.white.opacity(0.5)))
                                .foregroundColor(Color(.colorWritten))
                                .cornerRadius(corners)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: corners)
                                .stroke(Color(.colorCulture), lineWidth: 5)
                        )
                        .fullScreenCover(isPresented: $isCulturePresented){
                            CultureView(numParticipants: $numParticipants, participants: $participants, numRounds: $numRounds, turnDuration: $turnDuration, onHome: onHome, selectedCountry : selectedCountry)
                        }
                        
                        Button(action: {
                            isOffensivePresented = true
                            
                        }) {
                            Text("Rumors")
                                .font(.custom("Atma", fixedSize: 25))
                                .bold()
                                .frame(width: 160, height: 160)
                                .background(Color(.white.opacity(0.5)))
                                .foregroundColor(Color(.colorWritten))
                                .cornerRadius(corners)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: corners)
                                .stroke(Color(.colorOffensive), lineWidth: 5)
                        )
                        .fullScreenCover(isPresented: $isOffensivePresented){
                            OffensiveView(numParticipants: $numParticipants, participants: $participants, numRounds: $numRounds, turnDuration: $turnDuration, onHome: onHome, selectedCountry : selectedCountry)
                        }
                        .padding()
                        
                    }//EndLazy
                    .padding(.bottom, 50)
                }
            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(
            numParticipants: .constant(3),
            participants: .constant(["Alice", "Bob", "Charlie"]),
            numRounds: .constant(1),
            turnDuration: .constant(60),
            onHome: {},
            selectedCountry: Country(name: "Italy", flagImage: "flags_italy")
        )
    }
}


