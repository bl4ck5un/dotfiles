import AppKit
import Foundation
import CryptoKit

final class ClipboardImageWatcher {
    private let pasteboard = NSPasteboard.general
    private var lastChangeCount: Int
    private var lastImageHash: String?
    private let saveDirectory: URL

    init(saveDirectory: URL) {
        self.saveDirectory = saveDirectory
        self.lastChangeCount = pasteboard.changeCount

        do {
            try FileManager.default.createDirectory(
                at: saveDirectory,
                withIntermediateDirectories: true
            )
            print("Watching clipboard. Saving images to: \(saveDirectory.path)")
        } catch {
            fputs("Failed to create directory: \(error)\n", stderr)
            exit(1)
        }
    }

    func run() {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { [weak self] _ in
            self?.checkClipboard()
        }

        RunLoop.current.add(timer, forMode: .common)
        RunLoop.current.run()
    }

    private func checkClipboard() {
        guard pasteboard.changeCount != lastChangeCount else { return }
        lastChangeCount = pasteboard.changeCount

        guard let image = NSImage(pasteboard: pasteboard) else { return }
        guard let pngData = image.pngData() else { return }

        let hash = SHA256.hash(data: pngData).map { String(format: "%02x", $0) }.joined()
        guard hash != lastImageHash else { return }
        lastImageHash = hash

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"

        let baseName = "clipboard_\(formatter.string(from: Date()))"
        let fileURL = uniqueFileURL(baseName: baseName, ext: "png")

        do {
            try pngData.write(to: fileURL)
            print("Saved image to \(fileURL.path)")
        } catch {
            fputs("Failed to save image: \(error)\n", stderr)
        }
    }

    private func uniqueFileURL(baseName: String, ext: String) -> URL {
        var candidate = saveDirectory.appendingPathComponent("\(baseName).\(ext)")
        var counter = 1

        while FileManager.default.fileExists(atPath: candidate.path) {
            candidate = saveDirectory.appendingPathComponent("\(baseName)_\(counter).\(ext)")
            counter += 1
        }

        return candidate
    }
}

extension NSImage {
    func pngData() -> Data? {
        guard
            let tiffData = self.tiffRepresentation,
            let bitmap = NSBitmapImageRep(data: tiffData)
        else {
            return nil
        }
        return bitmap.representation(using: .png, properties: [:])
    }
}

let targetPath = CommandLine.arguments.dropFirst().first ?? "\(NSHomeDirectory())/ClipboardImages"
let saveDirectory = URL(fileURLWithPath: targetPath, isDirectory: true)

let watcher = ClipboardImageWatcher(saveDirectory: saveDirectory)
watcher.run()
