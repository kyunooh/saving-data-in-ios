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
    func save(directory: FileManager.SearchPathDirectory) throws  {
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
//
//let images = try [Image](fileName: "images")
//images.map { UIImage(data: $0.pngData) }



public struct Sticker: Codable {
    public let name: String
    public let size: Int
    
    init(name: String, size: Int) {
        self.name = name
        self.size = size
    }
    
}



do {
    let s1 = Sticker(name: "a", size: 1)
    let s2 = Sticker(name: "b", size: 2)
    
    let stickers: Array<Sticker> = [s1, s2]
    
    let jsonEncoder = JSONEncoder()
    jsonEncoder.outputFormatting = .prettyPrinted
    let jsonUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        .appendingPathComponent("stickers")
    
    let stickersData = try jsonEncoder.encode(stickers)
    try stickersData.write(to: URL(fileURLWithPath: "stickers",
                            relativeTo: jsonUrl).appendingPathExtension("json"))
    
    let jsonDecoder = JSONDecoder()
    let savedJSONData = try Data(contentsOf: jsonUrl)
    let savedSticker = try jsonDecoder.decode([Sticker].self, from: savedJSONData)
    
    print(savedSticker)
} catch  {
    print(error)
}


