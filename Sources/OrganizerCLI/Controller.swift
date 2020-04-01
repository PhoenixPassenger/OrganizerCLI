//
//  Controller.swift
//  FolderOrganizer
//
//  Created by Rodrigo Silva Ribeiro on 13/03/20.
//  Copyright © 2020 Rodrigo Silva Ribeiro. All rights reserved.
//

import Foundation
import ColorizeSwift

@available(OSX 10.12, *)
class Controller: NSObject {
    
    
    
    let fm = FileManager.default
    
    // LÊ ARQUIVOS
    func readFiles(folder:URL) -> [URL] {
        do {
            
            let files = try fm.contentsOfDirectory(atPath: folder.path)
            return files.map{ return folder.appendingPathComponent($0)}
        } catch {
            print("This path is unavailable".bold().red())
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
        let fileToSniff:String = path
        let dirURL = home.appendingPathComponent(fileToSniff)
        let fileURLs:[URL]
        do {
            fileURLs = try fileManager.contentsOfDirectory(at: dirURL, includingPropertiesForKeys: nil)
        } catch {
            print(
                    """
            
            There is no such directory
            
            """.bold().red())
                
                exit(0)
        }
        
        
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
        
        Empty directory
        
        """.bold().red())
            
            exit(0)
        }
        
        guard let fileType = readLine() else {
            print(
                """
        
        Invalid entry

        """.bold().red())
            exit(0)
        }
        
        let choosed = fileType.components(separatedBy: set)
        var optChoosed = [Int].init()
        
        for opt in choosed{
            if let temp = Int(opt){
                if temp <= extensions.count {
                    optChoosed.append(temp)
                }else{
                    print(
                        """
                           
                           Invalid entry

                           """.bold().red())
                    exit(0)
                }
                
            }else{
                print(
                    """
        
        Invalid entry

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
        //system("clear")
        print(
            """
        
        Files transferred successfully

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
        let fileURLs:[URL]
        do {
            fileURLs = try fileManager.contentsOfDirectory(at: dirURL, includingPropertiesForKeys: nil)
        } catch {
            print(
                    """
            
            There is no such directory
            
            """.bold().red())
                
                exit(0)
        }
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
        
        Empty directory
        
        """.bold().red())
            
            exit(0)
        }
        
        guard let fileType = readLine() else {
            print(
                """
        
        Invalid entry

        """.bold().red())
            exit(0)
        }
        
        let choosed = fileType.components(separatedBy: set)
        var optChoosed = [Int].init()
        
        for opt in choosed{
            if let temp = Int(opt){
                if temp <= extensions.count {
                    optChoosed.append(temp)
                }else{
                    print(
                        """
                           
                           Invalid entry

                           """.bold().red())
                    exit(0)
                }
            }else{
                print(
                    """
        
        Invalidy entry
        
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
        //system("clear")
        print(
            """
        
        Files transferred successfully
        
        """.bold().underline().cyan())
    }
    
    
    func listAllFiles(_ path : String)throws {
        let fileManager = FileManager.default
        let home = fileManager.homeDirectoryForCurrentUser
        let fullPath =  home.appendingPathComponent(path)
        let files = readFiles(folder: fullPath)
        for file in files{
            if file.pathExtension.isEmpty {
                print((file.lastPathComponent).bold().colorize(.darkSeaGreen3_2, background: .black))
            }else{
                print((file.lastPathComponent).bold().colorize(.cyan2, background: .black))
            }
            
        }
    }
    
    func checkDuplicates(_ path : String)throws{
        let fileManager = FileManager.default
        let home = fileManager.homeDirectoryForCurrentUser
        let fullPath =  home.appendingPathComponent(path)
        let files = readFiles(folder: fullPath)
        var resp:Bool
        for file1 in files{
            for file2 in files {
                if(file1.lastPathComponent == file2.lastPathComponent){
                }
                else {
                    resp =  fileManager.contentsEqual(atPath:file1.path, andPath:file2.path)
                    if resp {
                        try fileManager.removeItem(atPath: file1.path)
                        print("File \(file2.lastPathComponent) that is a duplicate of \(file1.lastPathComponent) removed".bold().red())
                    }
                }
                
            }
        }
    }
    
    
    
}


