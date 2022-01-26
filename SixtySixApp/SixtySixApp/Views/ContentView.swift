import SwiftUI

struct ContentView: View {
    @State var OnboardingAppears: Bool = true
    var body: some View {
        NavigationView {
            VStack {
                Text("Main screen")
            }
            .navigationTitle("Meus hábitos")
        }
        .fullScreenCover(isPresented: $OnboardingAppears, content: {
            OnboardingView()
        })
    }
}

//Onboarding

struct OnboardingView: View {
    var body: some View{
        TabView {
            VStack {
                PageView(message: "Segundo um estudo da professora Jane Wardle, da University College of London, o cérebro humano leva, em média, 66 dias para se acostumar a fazer algo novo.", imageName: "seeding")
            }
            VStack {
                PageView(message: "Com o 66 dias, basta criar um novo hábito que você quer construir, escolher o dia que você quer começar (por que não hoje mesmo?) e escolher a hora do dia para ser lembrado!", imageName: "workout")
            }
            VStack {
                PageView(message: "Uma dica: que tal identificar um hábito que você se identifica, que te dê prazer ou que você sabe que é para o seu crescimenhhto profissional? É mais fácil seguir em frente quando temos um propósito!", imageName: "reading")
            }
            }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct PageView: View{
    let message: String
    let imageName: String
    
    var body: some View{
        VStack{
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 414 )
            Text(message)
                .font(.system(size: 17))
                .multilineTextAlignment(.leading)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
