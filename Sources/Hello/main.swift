#!/usr/share/swift/usr/bin/swift
//
//  main.swift
//  FolderOrganizer
//
//  Created by Rodrigo Silva Ribeiro on 13/03/20.
//  Copyright © 2020 Rodrigo Silva Ribeiro. All rights reserved.
//


import Commander

import ColorizeSwift

import Foundation

//CLASSES FOR CODABLE
class FilePaths: Codable {
    var path: String?
    var folder: Folder?
}
class Folder: Codable {
    var folderName: String?
    var dataTypes: String?
    var folder: Folder?
}

//FUNCS
// func getJson() -> FilePaths? {
//     let file = "/Desktop/FolderOrganizer/FolderOrganizer/file.json"
//     let reader = JSONReader(file)
//     guard let dados = try? reader.readJsonData() else {
//         exit(0)
//     }
//     let decoder = JSONDecoder()
//     let object = try? decoder.decode(FilePaths.self, from: dados)
//     return object
// }

func listAllFiles(_ path : String)throws {
    let con = Controller.init()
    let fileManager = FileManager.default
    let home = fileManager.homeDirectoryForCurrentUser
    let fullPath =  home.appendingPathComponent(path)
    let files = con.readFiles(folder: fullPath)
    for file in files{
        if file.pathExtension.isEmpty {
            print((file.lastPathComponent).bold().colorize(.darkSeaGreen3_2, background: .black))
        }else{
            print((file.lastPathComponent).bold().colorize(.cyan2, background: .black))
        }
        
    }
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


let main = {
    Group{
        $0.command(("organize"),
                   Option("path",default: "/Desktop/teste", flag: "p" ,description: "Type what the root path for organize"),
                   description: "Organize the files in some path"
        ) { path in
            try transferAllOfType(path)
        };
        
        $0.command(("list"),Option("path", default: "/", flag: "p",description: "Type what the root path for organize"), description: "List All Files in some path"){path in
            try listAllFiles(path)
        }
        
        
    }
}


main().run()




