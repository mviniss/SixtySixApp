import SwiftUI

struct ContentView: View {
    @State var ShowOnboarding: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, World!")
                    .padding()
            }
            .navigationTitle("Meus hábitos")
        }
        .fullScreenCover(isPresented: $ShowOnboarding, content:{
            OnboardingView()
        })
    }
}
struct OnboardingView: View{
    var body: some View{
        TabView{
            PageView()
                .background(Color.gray)
            PageView()
                .background(Color.green)
            PageView()
                .background(Color.red)
            PageView()
                .background(Color.white)
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct PageView: View {
    var body: some View{
        Image(systemName: "seeding")
            .resizable()
            .padding()
        Text("Teste 5")
            .font(.system(size: 30))
        Text("Teste 6")
            .font(.system(size: 24))
        foregroundColor(Color(.secondaryLabel))
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
