import SwiftUI

struct StoryView: View {
    var body: some View {
        NavigationStack {
            ZStack {
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
//                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            }
        }
    }
}

#Preview {
    StoryView()
}
