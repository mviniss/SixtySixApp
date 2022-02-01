import SwiftUI

//NewHabitScreen
struct NewHabit: View {
    
    @State private var habitName = ""
    @State private var startDate = Date()
    @State private var notes = ""
    @State private var noteArray: [String] = []
    @State private var shouldSendAlert = false
    
    var body: some View {
            ZStack {
                Spacer()
                Form {
                    Section{
                        TextField("Título", text: $habitName)
                    }
                    Section{
                        DatePicker("Começa", selection: $startDate)
                    }
                    Section{
                        Toggle("Alerta", isOn: $shouldSendAlert)
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                    }
                    Section{
                        TextField("Notas", text: $notes)
                            .frame(width: 374, height: 240, alignment: .topLeading)
                    }
                    NavigationLink(destination: CreatedHabit(), label: {
                        Button(action: saveHabit, label: {
                            Text("Salvar")
                        })
                    })
                }
                .accentColor(Color(.label)).navigationBarTitle("Novo hábito", displayMode: .inline)
            }
    }
    func saveHabit(){
        noteArray.append(habitName)
        noteArray.append(notes)
    }
}


struct NewHabit_Previews: PreviewProvider {
    static var previews: some View {
        NewHabit()
    }
}
