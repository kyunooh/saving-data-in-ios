import Foundation

extension FileMnager {
    static var documentDirectoryURL: URL {
        return `default`.urls(for: .documentDirectory, .userDomainMask)[0]
    }
}
