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




let controller = Controller.init()

let main = {
    Group{
        $0.command(("organize"),
                   Option("path",default: "/Desktop/teste", flag: "p" ,description: "Type what the root path for organize"),
                   description: "Organize the files in a folder for each type"
        ) { path in
            try controller.transferAllOfType(path)
        };
        
        $0.command(("list"),Option("path", default: "/", flag: "p",description: "Type what the root path for organize"), 
        description: "List all Files in a folder"
        ){path in
        do{
            try listAllFiles(path)
        } catch{
            print("Erro".bold().red())
        }
            
        };

        $0.command(("organizeName"),
                   Option("path",default: "/Desktop/teste", flag: "p" ,description: "Type what the root path for organize"),
                   Option("name",default: "organizer", flag: "n" ,description: "Type what a name for the folder to organize"),
                   description: "Organize the choosed files in a folder"
        ) { path,name in
            try controller.transferAllOfTypeName(path,name)
        };
        
        
    }
}


main().run()




