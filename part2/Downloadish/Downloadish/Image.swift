import UIKit

struct Image: Decodable {
    enum Kind: String, Decodable {
        case scene
        case sticker
    }
    
    enum DecodingError: Error {
        case missingFile
    }
    
    let name: String
    let kind: Kind
    let pngData: Data
    init(fileName: String) throws {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw DecodingError.missingFile
        }
        let decoder = JSONDecoder()
        let data = try Data(contentsOf: url)
        self = try decoder.decode(Image.self, from: data)
        
    }
    func save(directory: FileManager.SearchPathDirectory) throws {
        let kindDirectoryURL = URL(
            fileURLWithPath: kind.rawValue,
            relativeTo: FileManager.default.urls(for: directory, in: .userDomainMask)[0]
        )
        
        try? FileManager.default.createDirectory(at: kindDirectoryURL,
                                                 withIntermediateDirectories: true)
        
        try pngData.write(to: kindDirectoryURL.appendingPathComponent(name).appendingPathExtension("png"),
                          options: .atomic)
    }
}

//let image = try Image(fileName: "image")
//UIImage(data: image.pngData)

extension Array where Element == Image {
    init(fileName: String) throws {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw Image.DecodingError.missingFile
        }
        let decoder = JSONDecoder()
        let data = try Data(contentsOf: url)
        self = try decoder.decode([Image].self, from: data)
        
    }
}
