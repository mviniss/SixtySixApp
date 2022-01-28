import SwiftUI

//NewHabitScreen

struct NewHabit: View {
    
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
                    .background(Color.gray.opacity(0.1).cornerRadius(10))
                    .foregroundColor(.gray)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                
                DatePicker("Início", selection: $startDate, in:Date()..., displayedComponents: [.date, .hourAndMinute])
                    .padding()
                    .frame(width: 374, height: 60, alignment: .leading)
                    .background(Color.gray.opacity(0.1).cornerRadius(10))
                    .foregroundColor(.black)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                
                Text("Término")
                    .padding()
                    .frame(width: 374, height: 60, alignment: .leading)
                    .background(Color.gray.opacity(0.1).cornerRadius(10))
                    .foregroundColor(.black)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                
                Toggle("Alerta", isOn: $setAlert)
                    .padding()
                    .frame(width: 374, height: 60, alignment: .leading)
                    .background(Color.gray.opacity(0.1).cornerRadius(10))
                    .foregroundColor(.black)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                
                TextField("Notas", text: $noteText)
                    .padding()
                    .frame(width: 374, height: 240, alignment: .topLeading)
                    .background(Color.gray.opacity(0.1).cornerRadius(10))
                    .foregroundColor(.black)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                ForEach(noteArray, id:\.self) { data in
                    Text(data)
                }
            }
            .padding()
            .navigationTitle("Novo hábito")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button{
                    } label: {
                        Label ("Salvar", systemImage: "square.and.arrow.down")
                            .toolbar{
                                ToolbarItemGroup(placement: .navigationBarLeading){
                                    Button{
                                    } label: {
                                        Label ("Cancelar", systemImage: "chevron.left")
                                    }
                                }
                            }
                    }
                }
            }
        }
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
