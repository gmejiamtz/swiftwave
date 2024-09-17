import Foundation

struct FileInfo: Identifiable, Hashable {
    let name: String
    let isDir: Bool
    let isSymlink: Bool
    let isSymlinkToDir: Bool
    let id = UUID()
}

func list_of_files(at path: String) -> [FileInfo]? {
    var fileInfos: [FileInfo] = []
    let fileManager = FileManager.default
    
    do {
        let items = try fileManager.contentsOfDirectory(atPath: path)
        for item in items {
            // Skip hidden files (those starting with a dot)
            if item.hasPrefix(".") { continue }
            
            let fullPath = (path as NSString).appendingPathComponent(item)
            var isDir: ObjCBool = false
            let isSymlink = (try? fileManager.destinationOfSymbolicLink(atPath: fullPath)) != nil

            if fileManager.fileExists(atPath: fullPath, isDirectory: &isDir) {
                var isSymlinkToDir = false
                if isSymlink {
                    var destinationIsDir: ObjCBool = false
                    let destinationPath = try? fileManager.destinationOfSymbolicLink(atPath: fullPath)
                    if let destinationPath = destinationPath, fileManager.fileExists(atPath: destinationPath, isDirectory: &destinationIsDir) {
                        isSymlinkToDir = destinationIsDir.boolValue
                    }
                }

                fileInfos.append(FileInfo(name: item, isDir: isDir.boolValue, isSymlink: isSymlink, isSymlinkToDir: isSymlinkToDir))
            }
        }
    } catch {
        print("Error while enumerating files: \(error.localizedDescription)")
        return nil
    }
    return fileInfos
}

func read_file(path: String) -> String? {
    do {
        let data = try Data(contentsOf: URL(string: "file://" + path)!)
        if let string = String(data: data, encoding: .utf8) {
            print("File contents: \(string)")
            return string
        }
    } catch {
        print("Error reading file: \(error)")
        return nil
    }
    return nil
}
