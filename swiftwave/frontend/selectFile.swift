import SwiftUI

struct SelectFileView: View {
    @State private var files: [FileInfo] = []
    @State private var currentDirectory: String = NSHomeDirectory()

    var body: some View {
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
                        Text(file.name)
                            .foregroundColor(file.isDir ? .blue : .white)
                            .onTapGesture {
                                handleFileSelection(file)
                            }
                    }
                }
                .background(Color.black)
            }
            .onAppear(perform: loadFiles)
    }

    func loadFiles() {
        files = list_of_files(at: currentDirectory) ?? []
        files.sort { $0.name.localizedCompare($1.name) == .orderedAscending }
    }

    func handleFileSelection(_ file: FileInfo) {
        if file.isDir {
            currentDirectory = (currentDirectory as NSString).appendingPathComponent(file.name)
            loadFiles()
        } else {
            navigateToWaveformView()
        }
    }

    func goUpDirectory() {
        // Navigate to the parent directory
        currentDirectory = (currentDirectory as NSString).deletingLastPathComponent
        loadFiles()
    }

    func navigateToWaveformView() {
        // Handle the navigation to the waveform view
        print("Navigating to waveform view")
    }
}
