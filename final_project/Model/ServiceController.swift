//
//  ServiceController.swift
//  final_project
//
//  Created by Pruthvi Gandhi on 2021-12-12.
//

import Foundation

class ServiceController {

    static var shared = ServiceController()
    
    func getDrugInfo(drug:String, handler: @escaping ([Info])->Void){
        var request = URLRequest(url: URL(string: "https://api.fda.gov/drug/ndc.json?search=generic_name:"+drug+"&limit=5")!)
                request.httpMethod = "GET"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
             
                let task =  URLSession.shared.dataTask(with: request) { data, apiresponse, error in
            
            if let error = error {
                print(error)
                handler([Info]())
            }
            
            
            // check response code
            else if let correct_data = data {
                do{
                let decoder = JSONDecoder()
                    let resultFromDeconder = try decoder.decode(Result.self,from: correct_data)
                    handler(resultFromDeconder.results)
                    print(resultFromDeconder)
                }catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
