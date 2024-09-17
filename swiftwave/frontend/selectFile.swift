import SwiftUI

struct SelectFileView: View {
    @State private var files: [FileInfo] = []
    @State private var currentDirectory: String = NSHomeDirectory()
    @State private var selectedFile: FileInfo?

    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to swiftwave! Select .vcd file")
                    .font(.largeTitle)
                    .padding()

                List {
                    // "Back" button to navigate to the parent directory
                    if currentDirectory != NSHomeDirectory() {
                        Button(action: goUpDirectory) {
                            Text("Back")
                                .foregroundColor(.blue)
                        }
                    }
                    
                    // Displaying the files and directories
                    ForEach(files, id: \.self) { file in
                        NavigationLink(
                            destination: destinationView(for: file),
                            label: {
                                Text(file.name)
                                    .foregroundColor(file.isDir ? .blue : .white)
                            }
                        ).navigationBarBackButtonHidden(true)
                    }
                }
                .background(Color.black)
            }
            .onAppear(perform: loadFiles)
        }
    }

    func loadFiles() {
        files = list_of_files(at: currentDirectory) ?? []
        files.sort { $0.name.localizedCompare($1.name) == .orderedAscending }
    }

    func handleFileSelection(_ file: FileInfo) {
        if file.isDir {
            currentDirectory = (currentDirectory as NSString).appendingPathComponent(file.name)
            loadFiles()
        }
    }

    func goUpDirectory() {
        // Navigate to the parent directory
        currentDirectory = (currentDirectory as NSString).deletingLastPathComponent
        loadFiles()
    }

    @ViewBuilder
    func destinationView(for file: FileInfo) -> some View {
        if file.isDir {
            SelectFileView() // Navigate to the same view but with the new directory
        } else {
            WaveformMainView(file_path: (currentDirectory as NSString).appendingPathComponent(file.name), file_name: file.name) // Navigate to the waveform_main view
        }
    }
}

struct selectViewPreview: PreviewProvider {
    static var previews: some View {
        SelectFileView()
    }
}
