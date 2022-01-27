//Calendar

import SwiftUI

struct Calendar: View {
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var title = String()
    
    var body: some View {
        Form {
            TextField("Título", text: $title)
            DatePicker("Início", selection: $startDate, in:Date()...)        }
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        Calendar()
    }
}
