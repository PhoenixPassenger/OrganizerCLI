//
//  Controller.swift
//  FolderOrganizer
//
//  Created by Rodrigo Silva Ribeiro on 13/03/20.
//  Copyright © 2020 Rodrigo Silva Ribeiro. All rights reserved.
//

import Foundation

class Controller: NSObject {
    
    
    
    let fm = FileManager.default
    
    // LÊ ARQUIVOS
    func readFiles(folder:URL) -> [URL] {
        do {
            
            let files = try fm.contentsOfDirectory(atPath: folder.path)
            return files.map{ return folder.appendingPathComponent($0)}
        } catch {
            print(error)
            return []
        }
    }
    
    
    // CRIAR DIRETÓRIO
    func createFolder(_ path : URL, _ directoryName : String) throws -> URL{
        let folder = path
        let folderCreate = folder.appendingPathComponent(directoryName)
        _ = try fm.createDirectory(at: folderCreate, withIntermediateDirectories: true, attributes: nil)
        return folderCreate
    }
    
    
    // TRANSFERIR ARQUIVOS ENTRE DOIS DIRETÓRIOS
    func transferFiles(_ srcPath: URL, _ destPath: URL) throws{
        try FileManager.default.moveItem(at: srcPath, to: destPath)
        
    }
    
    
    // // APAGAR ARQUIVOS
    // func deleteFiles() throws -> Void {
    //     func deleteIndeed(_ files:[URL],_ toDelete:Int)throws{
    //         try fm.trashItem(at: files[toDelete - 1], resultingItemURL: nil)
    //     }
    //     print("Digite o path: ")
        
    //     let path = readLine()
    //     guard let unPath = path else{
    //         print("Digite um numero valido.")
    //         exit(0)
            
    //     }
    //     let folder = fm.homeDirectoryForCurrentUser.appendingPathComponent(unPath)
        
    //     print("")
    //     let files = readFiles(folder:folder)
    //     files.enumerated().forEach { (i, url) in
    //         print(String(i+1) + " - " + url.lastPathComponent  )
    //     }
    //     print("")
    //     let indices = readLine() ?? nil
    //     guard let unIndices = indices else{
    //         print("Digite um numero valido.")
    //         exit(0)
    //     }
        
    //     var set = CharacterSet()
    //     set.insert(charactersIn: ", ;.")
    //     let choosed = unIndices.components(separatedBy: set)
    //     try choosed.indices.forEach{ (val) in
    //         let toDelete = Int(choosed[val]) ?? -1
    //         let isDir = (try files[toDelete - 1].resourceValues(forKeys: [.isDirectoryKey])).isDirectory
    //         if isDir ?? true{
    //             print("ARE YOU SURE? y/N :")
    //             let answer = readLine() ?? "N"
    //             print(answer)
    //             let answerBool = answer == "y"
    //             if answerBool{
    //                 try deleteIndeed(files, toDelete)
    //             }else{
    //                 print("Ok then")
    //             }
    //         }else{
    //             try deleteIndeed(files, toDelete)
    //         }
    //     }
        
        
    // }
    
    
    
    
    
    
}

