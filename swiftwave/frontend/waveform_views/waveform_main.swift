//
//  waveform_main.swift
//  swiftwave
//
//  Created by Gary Mejia on 9/3/24.
//

import Foundation
import SwiftUI

struct WaveformMainView: View {
    let file_path: String
    let file_name: String
    @State private var vcd_string: String = ""
    var body: some View {
        VStack{
            Text("Main Waveform")
            Text("To distribute the file at path: ")
            Text(file_path)
        }
        .navigationTitle(file_name)
        .onAppear(perform: read_vcd)
    }
    func read_vcd() {
        print("Trying to read path: ", file_path)
        vcd_string = read_file(path: file_path) ?? ""
    }
}

struct waveform_main_Previews: PreviewProvider {
    static var previews: some View {
        WaveformMainView(file_path: "/Users/gmm117/Library/Containers/gmm.swiftwave/Data/counter.vcd", file_name: "TDB")
    }
}
