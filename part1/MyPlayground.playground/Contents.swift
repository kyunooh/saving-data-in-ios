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

try mysteryData.write(to: mysteryDataURL.appendingPathExtension("txt"))


let challengeString = "jelly"
let challengeStringURL = URL(
    fileURLWithPath: challengeString, relativeTo: FileManager.documentDirectoryURL)
    .appendingPathExtension("txt")

challengeStringURL.lastPathComponent

try challengeString.write(to: challengeStringURL, atomically: true, encoding: .utf8)

let challengeStringData = try challengeString.data(using: .utf8)
try challengeStringData?.write(to: challengeStringURL)
let savedChallengeString = try String(contentsOf: challengeStringURL)
