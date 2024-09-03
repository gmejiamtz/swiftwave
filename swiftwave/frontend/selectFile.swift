//
//  selectFile.swift
//  swiftwave
//
//  Created by Gary Mejia on 9/2/24.
//

import SwiftUI

struct SelectFileView: View {
    @State private var files: [String] = []

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Welcome to swiftwave! Select .vcd file")
                    .font(.largeTitle)
                    .padding()

                List(files, id: \.self) { file in
                    Text(file)
                }
                .frame(height: geometry.size.height)
            }
            .onAppear(perform: loadFiles)
        }
    }
    func loadFiles() {
          if let allFileItems = list_of_files() {
              files = allFileItems
              files.sort()
              print(files)
          } else {
              print("Failed to retrieve files.")
          }
      }
}
