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
    
    func transferAllOfType(_ path : String) throws {
    let fileManager = FileManager.default
    let home = fileManager.homeDirectoryForCurrentUser
    var extensions  = [String]()
    let fm = Controller.init()
    var set = CharacterSet()
    set.insert(charactersIn: ", ;.")
    
    //    let dadosJSon = getJson()
    //    guard let unJson = dadosJSon else {
    //        exit(0)
    //    }
    //
    //    guard let fileToSniff = unJson.path else {
    //        exit(0)
    //    }
    let fileToSniff:String = path
    let dirURL = home.appendingPathComponent(fileToSniff)
    let fileURLs = try fileManager.contentsOfDirectory(at: dirURL, includingPropertiesForKeys: nil)
    
    
    
    
    for file in fileURLs {
        if !extensions.contains(file.pathExtension) && file.pathExtension != ""{
            extensions.append(file.pathExtension)
        }
    }
    
    
    
    for ext in extensions{
        var linha = String(1+(extensions.firstIndex(of: ext)!))
        linha.append(" : ")
        linha.append(ext)
        print(linha)
    }
    
    if extensions.isEmpty {
        print(
        """
        
        Nao ha arquivos nessa pasta
        
        """.bold().red())
        
        exit(0)
    }

    guard let fileType = readLine() else {
        print(
        """
        
        Valor de entrada invalido
        
        """.bold().red())
        exit(0)
    }
    
    let choosed = fileType.components(separatedBy: set)
    var optChoosed = [Int].init()

    for opt in choosed{
        if let temp = Int(opt){
            optChoosed.append(temp)
        }else{
        print(
        """
        
        Valor de entrada invalido
        
        """.bold().red())
        exit(0)
        }
    }
    
    for choose in optChoosed{
        var newDirectory = try fm.createFolder(dirURL, extensions[(choose) - 1])
        for file in fileURLs {
            if (file.pathExtension == extensions[choose - 1]) {
                newDirectory = newDirectory.appendingPathComponent(file.lastPathComponent)
                try fm.transferFiles(file, newDirectory)
                newDirectory = newDirectory.deletingLastPathComponent()
            }
        }
    }
    system("clear")
    print(
        """
        
        Arquivos transferidos com sucesso!
        
        """.bold().underline().cyan())
}



func transferAllOfTypeName(_ path : String,_ name : String) throws {
    let fileManager = FileManager.default
    let home = fileManager.homeDirectoryForCurrentUser
    var extensions  = [String]()
    let fm = Controller.init()
    var set = CharacterSet()
    set.insert(charactersIn: ", ;.")

    let fileToSniff:String = path
    let dirURL = home.appendingPathComponent(fileToSniff)
    let fileURLs = try fileManager.contentsOfDirectory(at: dirURL, includingPropertiesForKeys: nil)
    
    
    
    
    for file in fileURLs {
        if !extensions.contains(file.pathExtension) && file.pathExtension != ""{
            extensions.append(file.pathExtension)
        }
    }
    
    
    
    for ext in extensions{
        var linha = String(1+(extensions.firstIndex(of: ext)!))
        linha.append(" : ")
        linha.append(ext)
        print(linha)
    }
    
    if extensions.isEmpty {
        print(
        """
        
        Nao ha arquivos nessa pasta
        
        """.bold().red())
        
        exit(0)
    }

    guard let fileType = readLine() else {
        print(
        """
        
        Valor de entrada invalido
        
        """.bold().red())
        exit(0)
    }
    
    let choosed = fileType.components(separatedBy: set)
    var optChoosed = [Int].init()

    for opt in choosed{
        if let temp = Int(opt){
            optChoosed.append(temp)
        }else{
        print(
        """
        
        Valor de entrada invalido
        
        """.bold().red())
        exit(0)
        }
    }
    
    for choose in optChoosed{
        var newDirectory = try fm.createFolder(dirURL, name)
        for file in fileURLs {
            if (file.pathExtension == extensions[choose - 1]) {
                newDirectory = newDirectory.appendingPathComponent(file.lastPathComponent)
                try fm.transferFiles(file, newDirectory)
                newDirectory = newDirectory.deletingLastPathComponent()
            }
        }
    }
    system("clear")
    print(
        """
        
        Arquivos transferidos com sucesso!
        
        """.bold().underline().cyan())
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

