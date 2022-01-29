import SwiftUI

struct Habit: View {
    
    @AppStorage("onboardingAppears") var onboardingAppears: Bool = true
    
    let imageName: String
    var body: some View {
        NavigationView {
                VStack {
                    Spacer()
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 414 )
                    NavigationLink(destination: NewHabit(), label: {
                        Text("Criar novo hábito")
                            .bold()
                            .frame(width: 374, height: 60, alignment: .center)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    })
                }
            .navigationTitle("Meus hábitos")
        }
        .fullScreenCover(isPresented: $onboardingAppears, content: {OnboardingView(onboardingAppears: $onboardingAppears)
        })
    }
    
    struct Habit_Previews: PreviewProvider {
        static var previews: some View {
            Habit(imageName: "yoga")
        }
    }
}
