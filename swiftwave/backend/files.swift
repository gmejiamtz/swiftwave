//
//  files.swift
//  swiftwave
//
//  Created by Gary Mejia on 9/2/24.
//

import Foundation

func list_of_files() -> [String]? {
    var paths: [String] = []
    let fileManager = FileManager.default
    //later include non home directory launches
    let current_user = NSUserName()
    let pwd = fileManager.homeDirectory(forUser: current_user)?.path(percentEncoded: false) ?? ""
    do {
        let items = try fileManager.contentsOfDirectory(atPath: pwd)
        for item in items {
            if !item.hasPrefix(".") {
                paths.append(item)
            }
        }
    } catch {
        print("backend/files.swift:list_of_files() failed!")
        return nil
    }
    return paths
}
