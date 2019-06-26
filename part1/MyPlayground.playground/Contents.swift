import UIKit

FileManager.documentDirectoryURL

try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

let mysteryDataURL = URL(
    fileURLWithPath: "mystery",
    relativeTo: FileManager.documentDirectoryURL
)


let challengeString = "jelly"
let challengeStringURL = URL(
    fileURLWithPath: challengeString, relativeTo: FileManager.documentDirectoryURL)
    .appendingPathExtension("txt")

challengeStringURL.lastPathComponent
