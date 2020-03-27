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

//FUNCS


if #available(OSX 10.12, *) {
    let controller = Controller.init()
    let main = {
        Group{
            $0.command(("organize"),
                       Option("path",default: "/Desktop", flag: "p" ,description: "Type what the root path for organize"),
                       description: "Organize the files in a folder for each type"
            ) { path in
                try controller.transferAllOfType(path)
            };
            
            $0.command(("list"),Option("path", default:"/Desktop", flag: "p",description: "Type what the root path for organize"),
            description: "List all Files in a folder"
            ){path in
            do{
                try controller.listAllFiles(path)
            } catch{
                print("Erro".bold().red())
            }
                
            };

            $0.command(("organizeName"),
                       Option("path",default: "/Desktop", flag: "p" ,description: "Type what the root path for organize"),
                       Option("name",default: "organizer", flag: "n" ,description: "Type what a name for the folder to organize"),
                       description: "Organize the choosed files in a folder"
            ) { path,name in
                try controller.transferAllOfTypeName(path,name)
            };
            
            $0.command(("duplicates"),Option("path", default:"/Desktop", flag: "p",description: "Type what the root path for check duplicates"),
            description: "Check if there is any duplicated file and erase if it has"
            ){path in
                try controller.checkDuplicates(path)
            };
            
        }
    }


    main().run()




} else {
        print("""
    incompatible version of macOS, supported since OSX 10.12
 """)
}


