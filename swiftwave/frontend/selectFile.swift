import SwiftUI

struct SelectFileView: View {
    @State private var files: [FileInfo] = []

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Welcome to swiftwave! Select .vcd file")
                    .font(.largeTitle)
                    .padding()

                List(files, id: \.self) { file in
                    Text(file.name)
                        .foregroundColor(file.isDir ? .blue : .white)
                }
                .frame(height: geometry.size.height)
                .background(Color.black)
            }
            .onAppear(perform: loadFiles)
        }
    }
    func loadFiles() {
          if let allFileItems = list_of_files() {
              files = allFileItems
              files = files.sorted { $0.name.localizedCompare($1.name) == .orderedAscending }
          } else {
              print("Failed to retrieve files.")
          }
      }
}
