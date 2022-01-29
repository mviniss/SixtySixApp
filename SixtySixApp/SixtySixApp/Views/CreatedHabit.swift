import SwiftUI

struct CreatedHabit: View {
    
    @State private var noteArray: [String] = []
    
    var body: some View {
        ForEach(noteArray, id:\.self) { data in
            Text("M")
        }
        
        ForEach(noteArray, id:\.self) { data in
            Text(data)
        }
        
    }
    
}

struct CreatedHabit_Previews: PreviewProvider {
    static var previews: some View {
        CreatedHabit()
    }
}
