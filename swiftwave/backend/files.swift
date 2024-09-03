import Foundation

struct FileInfo: Identifiable, Hashable {
    let name: String
    let isDir: Bool
    let id = UUID()
}

func list_of_files() -> [FileInfo]? {
    var files: [FileInfo] = []
    let fileManager = FileManager.default
    //later include non home directory launches
    let current_user = NSUserName()
    let pwd = fileManager.homeDirectory(forUser: current_user)?.path(percentEncoded: false) ?? ""
    do {
        let items = try fileManager.contentsOfDirectory(atPath: pwd)
        for item in items {
            if !item.hasPrefix(".") {
                //print("check path: ", pwd +  item)
                let file_attr = try fileManager.attributesOfItem(atPath: pwd  + item)
                let file_type = file_attr[FileAttributeKey.type] ?? nil
                let is_dir = file_type as! String == "NSFileTypeDirectory"
                let is_reg = file_type as! String == "NSFileTypeRegular"
                if is_dir || is_reg {
                    files.append(FileInfo(name: item, isDir: is_dir))
                }
            }
        }
    } catch {
        print("backend/files.swift:list_of_files() failed!")
        return nil
    }
    return files
}
