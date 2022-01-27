import Foundation
import SwiftUI

//Onboarding

struct OnboardingView: View {
    @Binding var onboardingAppears: Bool
    var body: some View{
        TabView {
            PageView(message: "Segundo um estudo da professora Jane Wardle, da University College of London, o cérebro humano leva, em média, 66 dias para se acostumar a fazer algo novo.", imageName: "seeding", startButton: false, onboardingAppears: $onboardingAppears)
            PageView(message: "Com o 66 dias, basta criar um novo hábito que você quer construir, escolher o dia que você quer começar (por que não hoje mesmo?) e escolher a hora do dia para ser lembrado!", imageName: "workout", startButton: false, onboardingAppears: $onboardingAppears)
            PageView(message: "Uma dica: que tal começar um hábito que você se identifica, que te dê prazer ou que você sabe que é para o seu crescimento profissional? É mais fácil seguir em frente quando temos um propósito!", imageName: "reading", startButton: true, onboardingAppears: $onboardingAppears)
            }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct PageView: View{
    let message: String
    let imageName: String
    let startButton: Bool
    //Essa variável @Binding é a que liga o onboarding à HomeScreen
    @Binding var onboardingAppears: Bool
    var body: some View{
        VStack{
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 414 )
            Text(message)
                .font(.system(size: 17))
                .multilineTextAlignment(.leading)
                .padding()
            
            if startButton{
                Button(action: {
                    onboardingAppears.toggle()
                }, label: {
                    Text("Começar")
                        .bold()
                        .font(.system(size: 17))
                        .frame(width: 122, height: 44, alignment: .center)
                        .foregroundColor(Color.white)
                        .background(Color.purple)
                        .cornerRadius(5)
                })
            }
        }
    }
}
