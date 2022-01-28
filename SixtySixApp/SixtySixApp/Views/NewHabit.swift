import SwiftUI

//NewHabitScreen

struct NewHabit: View {
    
//    @AppStorage("onboardingAppears") var onboardingAppears: Bool = true
    
    @State var noteText: String = ""
    @State var noteTitle: String = ""
    @State var noteArray: [String] = []
    @State private var startDate: Date = Date()
    @State var setAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Título", text: $noteTitle)
                    .padding()
                    .frame(width: 374, height: 60, alignment: .leading)
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                    .foregroundColor(.black)
                    .font(.headline)
                
                DatePicker("Início", selection: $startDate, in:Date()..., displayedComponents: [.date, .hourAndMinute])
                    .padding()
                    .frame(width: 374, height: 60, alignment: .leading)
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                    .foregroundColor(.black)
                    .font(.headline)
                
                Text("Término")
                    .padding()
                    .frame(width: 374, height: 60, alignment: .leading)
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                    .foregroundColor(.black)
                    .font(.headline)
                
                Toggle("Alerta", isOn: $setAlert)
                    .padding()
                    .frame(width: 374, height: 60, alignment: .leading)
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                    .foregroundColor(.black)
                    .font(.headline)
                
                TextField("Notas", text: $noteText)
                    .padding()
                    .frame(width: 374, height: 240, alignment: .topLeading)
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                    .foregroundColor(.black)
                    .font(.headline)
                
                Button(action: {
                    saveNote()
                }, label: {
                    Text("Salvar".uppercased())
                        .padding()
                        .frame(width: 374, height: 60, alignment: .center)
                        .background(Color.blue.cornerRadius(10))
                        .foregroundColor(.white)
                        .font(.headline)
                })
                
                ForEach(noteArray, id:\.self) { data in
                    Text(data)
                }
            }
            .padding()
            .navigationTitle("Novo hábito")
        }
//        .fullScreenCover(isPresented: $onboardingAppears, content: {OnboardingView(onboardingAppears: $onboardingAppears)
//              })
    }
    
    func saveNote(){
        noteArray.append(noteTitle)
        noteArray.append(noteText)
    }
}

struct NewHabit_Previews: PreviewProvider {
    static var previews: some View {
        NewHabit()
    }
}
