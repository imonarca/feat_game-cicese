//
//  saveData.swift
//  saveData
//
//  Created by Maria Fernanda Monarca Lopez  on 25/08/21.
//

import Foundation




class saveData {
    
    var output:OutputStream?
    var csvWriter:CHCSVWriter?
    var documentDirectoryPath:String?
    var documentURL:URL?
    var nameFile:String="file"
    
    
    func generateTxt(for sFileName:String){
        documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as String
        
        documentURL = URL(fileURLWithPath: documentDirectoryPath!).appendingPathComponent(sFileName)
        
    }
    
    func addTexto(for texto:String){
        if let handle = try? FileHandle(forWritingTo: documentURL!) {
            handle.seekToEndOfFile() // moving pointer to the end
            handle.write(texto.data(using: .utf8)!) // adding content
            handle.closeFile() // closing the file
        }
        else{
            do {
                try texto.write(to: documentURL!, atomically: true, encoding: .utf8)
                print("Content writted successfully!")
            } catch {
                print(error)
            }
        }
        
    }
    
    
    func generatedCSVFile(for sFileName:String){
        nameFile=sFileName
         output = OutputStream.toMemory()
         csvWriter = CHCSVWriter(outputStream: output, encoding: String.Encoding.utf8.rawValue, delimiter: ",".utf16.first!)
        
         documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as String
        
        documentURL = URL(fileURLWithPath: documentDirectoryPath!).appendingPathComponent(sFileName)
        
        csvWriter?.writeField("id")
        csvWriter?.writeField("time")
        csvWriter?.writeField("x")
        csvWriter?.writeField("y")
        csvWriter?.writeField("reactionTime")
        csvWriter?.writeField("Touchtype")
        csvWriter?.writeField("type")
        csvWriter?.writeField("forceN")
        csvWriter?.writeField("acX")
        csvWriter?.writeField("acY")
        csvWriter?.writeField("acZ")
        csvWriter?.writeField("gX")
        csvWriter?.writeField("gY")
        csvWriter?.writeField("gZ")
        csvWriter?.writeField("mRadious")
        csvWriter?.writeField("acelerationx")
        csvWriter?.writeField("acelerationY")
        csvWriter?.writeField("acelerationZ")
        csvWriter?.writeField("force")
        csvWriter?.finishLine()
        
        
        
    }
    func writeUser(for arrOfGestures:[[String]]){
        
        
    }
    func writeData(for arrOfGestures:[[String]] ){
        
        for(elements) in arrOfGestures.enumerated(){
            csvWriter?.writeField(elements.element[0])//ID
          
            csvWriter?.writeField(elements.element[1])//time
          
            csvWriter?.writeField(elements.element[2])//x
            csvWriter?.writeField(elements.element[3])//y
            csvWriter?.writeField(elements.element[4])//rt
            csvWriter?.writeField(elements.element[5])//ttype
            csvWriter?.writeField(elements.element[6])//type
            csvWriter?.writeField(elements.element[7])//force noramilizada
            csvWriter?.writeField(elements.element[8])//acX
            csvWriter?.writeField(elements.element[9])//acY
            csvWriter?.writeField(elements.element[10])//acZ
            csvWriter?.writeField(elements.element[11])//gx
            csvWriter?.writeField(elements.element[12])//gy
            csvWriter?.writeField(elements.element[13])//gz
            csvWriter?.writeField(elements.element[14])//mradious
            csvWriter?.writeField(elements.element[15])//aceleration
            csvWriter?.writeField(elements.element[16])//aceleration
            csvWriter?.writeField(elements.element[17])//aceleration
            csvWriter?.writeField(elements.element[18])//force
            csvWriter?.finishLine()
        }
    }
    
    func closeFile (){
        csvWriter?.closeStream()
        let buffer = (output?.property(forKey: .dataWrittenToMemoryStreamKey) as? Data)!
        
         do{
             try buffer.write(to: documentURL!)
             print("archivo creado")
        } catch {}
    }

        
}
