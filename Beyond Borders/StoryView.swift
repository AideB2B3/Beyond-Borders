import SwiftUI

struct StoryView: View {
    var body: some View {
        NavigationStack {
            ZStack {
//                Color(Color(red: 0.74, green: 0.78, blue: 0.69))
                Color(.colorWritten)
                    .ignoresSafeArea()
                
                TabView {
                    Image("storytelling1")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    Image("storytelling2")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .tabViewStyle(PageTabViewStyle())
//              .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            }
        }
    }
}

#Preview {
    StoryView()
}
