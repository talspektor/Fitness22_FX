//
//  DataManager.swift
//  Fitness22_Ex
//
//  Created by Tal talspektor on 07/01/2021.
//

import Foundation

class DataManager {
    
    public static let shared = DataManager()
    
    private init(){}
    
    public func getModel<T:Decodable>(resource: String, type: T.Type) -> T? {
        if let data = fetchData(resource) {
            do {
                print("\(data)")
                let jsonData = try JSONDecoder().decode(T.self, from: data) 
                print("decode success")
                return jsonData
            } catch {
                print(error)
            }
        }
        return nil
    }
    
    private func fetchData(_ resource: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: resource,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
               return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
//    public func write(to fileName: String, stringData: String) {
//        let pathDirectory = getDocumentsDirectory()
//        try? FileManager().createDirectory(at: pathDirectory, withIntermediateDirectories: true)
//        let filePath = pathDirectory.appendingPathComponent("\(fileName).json")
//        let json = try? JSONEncoder().encode(stringData)
//
//        do {
//            try json!.write(to: filePath)
//        } catch {
//            print(error)
//        }
        

//        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//
//            let fileURL = dir.appendingPathComponent(file)
//            do {
//                try stringData.write(to: fileURL, atomically: false, encoding: .utf8)
//            }
//            catch {
//                print(error)
//            }
//        }
//    }
    
//    private func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
//
//    public func read(from fileName: String) -> Data? {
//        let file = fileName
//
//        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//
//            let fileURL = dir.appendingPathComponent(file)
//            do {
//                if let data = try String(contentsOf: fileURL, encoding: .utf8).data(using: .utf8) {
//                    return data
//                }
//                return nil
//            }
//            catch {
//                print(error)
//            }
//        }
//        return nil
//    }
//
//    public func saveJsonToFile(_ jsonString: String, fileName: String) {
//        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
//                                                            in: .userDomainMask).first {
//            let pathWithFilename = documentDirectory.appendingPathComponent("\(fileName).json")
//            do {
//                try jsonString.write(to: pathWithFilename,
//                                     atomically: true,
//                                     encoding: .utf8)
//                print("saveJsonToFile succeded")
//            } catch {
//                print(error)
//            }
//        }
//    }
    
//    public func saveDataTofile(_ jsonString: String, fileName: String) {
//        if let jsonData = jsonString.data(using: .utf8),
//            let documentDirectory = FileManager.default.urls(for: .documentDirectory,
//                                                             in: .userDomainMask).first {
//            let pathWithFileName = documentDirectory.appendingPathComponent(fileName)
//            do {
//                try jsonData.write(to: pathWithFileName)
//                print("saveDataTofile succeded")
//            } catch {
//                print(error)
//            }
//        }
//    }
    
//    public func isFileExists(fileName: String) -> Bool {
//        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//            let url = NSURL(fileURLWithPath: path)
//            if let pathComponent = url.appendingPathComponent(fileName) {
//                let filePath = pathComponent.path
//                let fileManager = FileManager.default
//                if fileManager.fileExists(atPath: filePath) {
//                    print("FILE AVAILABLE")
//                    return true
//                } else {
//                    print("FILE NOT AVAILABLE")
//                    return false
//                }
//            } else {
//                print("FILE PATH NOT AVAILABLE")
//            }
//        return false
//    }
}
