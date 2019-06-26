import UIKit

FileManager.documentDirectoryURL

try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)


let mysteryBytes: [UInt8] = [
    240, 240, 159, 184, 185
]

let mysteryDataURL = URL(
    fileURLWithPath: "mystery",
     relativeTo: FileManager.documentDirectoryURL
)

let mysteryData = Data(bytes: mysteryBytes);
try mysteryData.write(to: mysteryDataURL)

let savedMysteryData = try Data(contentsOf: mysteryDataURL)
let savedMysteryBytes = Array(savedMysteryData);

savedMysteryBytes == mysteryBytes
mysteryData == savedMysteryData

let challengeString = "jelly"
let challengeStringURL = URL(
    fileURLWithPath: challengeString, relativeTo: FileManager.documentDirectoryURL)
    .appendingPathExtension("txt")

challengeStringURL.lastPathComponent
