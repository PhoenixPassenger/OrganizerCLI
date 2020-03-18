// //
// //  JSONReader.swift
// //  FolderOrganizer
// //
// //  Created by Rodrigo Silva Ribeiro on 13/03/20.
// //  Copyright © 2020 Rodrigo Silva Ribeiro. All rights reserved.
// //


// class JSONReader: NSObject {
//     var path: String
//     var home = FileManager.default.homeDirectoryForCurrentUser
    
//     init(_ path : String){
//         self.path = path
//     }
    
//     enum FileReaderErrors : Error{
//         case InvaldidPath
//     }
   
//     func convertToDictionary(_ text: String) -> [String: Any]? {
//         if let data = text.data(using: .utf8) {
//             do {
//                 return//
// //  JSONReader.swift
// //  FolderOrganizer
// //
// //  Created by Rodrigo Silva Ribeiro on 13/03/20.
// //  Copyright © 2020 Rodrigo Silva Ribeiro. All rights reserved.
// //


// class JSONReader: NSObject {
//     var path: String
//     var home = FileManager.default.homeDirectoryForCurrentUser
    
//     init(_ path : String){
//         self.path = path
//     }
    
//     enum FileReaderErrors : Error{
//         case InvaldidPath
//     }
   
//     func convertToDictionary(_ text: String) -> [String: Any]? {
//         if let data = text.data(using: .utf8) {
//             do {
//                 return try JSONSerialization.jsonObject(with: data, options:[]) as? [String: Any]
//             } catch {
//                 print(error.localizedDescription)
//             }
//         }
//         return nil
//     }


//     func readJsonDict() throws -> [String: Any] {
//         let fileURL = self.home.appendingPathComponent(self.path)
//         do {
//             let text2 = try String(contentsOf: fileURL, encoding: .utf8)
//             return self.convertToDictionary(text2)!
//         } catch {
//             throw FileReaderErrors.InvaldidPath
//         }
//     }
    
//     func readJsonData() throws -> Data {
//         let fileURL = self.home.appendingPathComponent(self.path)
//         do {
//             let text = try String(contentsOf: fileURL, encoding: .utf8)
//             let jsondados = text.data(using: .utf8)!
//             return jsondados
//         } catch {
//             throw FileReaderErrors.InvaldidPath
//         }
//     }
// }


//     }


//     func readJsonDict() throws -> [String: Any] {
//         let fileURL = self.home.appendingPathComponent(self.path)
//         do {
//             let text2 = try String(contentsOf: fileURL, encoding: .utf8)
//             return self.convertToDictionary(text2)!
//         } catch {
//             throw FileReaderErrors.InvaldidPath
//         }
//     }
    
//     func readJsonData() throws -> Data {
//         let fileURL = self.home.appendingPathComponent(self.path)
//         do {
//             let text = try String(contentsOf: fileURL, encoding: .utf8)
//             let jsondados = text.data(using: .utf8)!
//             return jsondados
//         } catch {
//             throw FileReaderErrors.InvaldidPath
//         }
//     }
// }

