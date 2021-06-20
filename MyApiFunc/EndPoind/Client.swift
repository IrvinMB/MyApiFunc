//
//  Client.swift
//  MyApiFunc
//
//  Created by Usuario on 19/6/21.
//
import Foundation

class Client: NetworkGeneric {
    let baseURL = "https://my-json-server.typicode.com/IrvinMB/mypost1/"
    var session: URLSession
    
    init() {
        self.session = URLSession.shared
    }
    
    func getList<T: Decodable>(type:T.Type,path:String,complete: @escaping (Result<T, ApiError>) -> Void) {
        let url = URL(string: "\(baseURL)\(path)")
        let request = URLRequest(url: url!)
        self.fetch(type: T.self, with: request, completion: complete)
    }
    func getItems<T: Decodable>(type:T.Type, parametros:[String:Any]? ,path:String,complete: @escaping (Result<T, ApiError>) -> Void) {
        let elPath:String
        if (parametros!.count > 0) {
            elPath="\(path)?"
        }else{
            elPath = path
        }
        var pathParametro:String = (parametros?.parameterToString())!
        print(pathParametro)
        let url = URL(string: "\(baseURL)\(path)\(pathParametro)")
        let request = URLRequest(url: url!)

        self.fetch(type: T.self, with: request, completion: complete)
    }
    
    func postJson<T: Codable>(post: T, path:String,complete:  @escaping (T) -> Void) {
        let url = URL(string: "\(baseURL)\(path)")

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = try! JSONEncoder().encode(post)
        request.httpBody = data
   
        self.fetch(type: T.self, with: request) { resut in
            switch resut{
            case .success(let post):
                complete(post)
            case .failure(let error):
                print(error)
            }
        }
    }
    func PutJson<T: Codable>(post: T, path:String, identificador:String,complete:  @escaping (T) -> Void) {
        let elPath:String="\(path)/"
        let url = URL(string: "\(baseURL)\(elPath)\(identificador)")
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = try! JSONEncoder().encode(post)
        request.httpBody = data
   
        self.fetch(type: T.self, with: request) { resut in
            switch resut{
            case .success(let post):
                complete(post)
            case .failure(let error):
                print(error)
            }
        }
    }
    func DeleteJson<T: Codable>(type:T.Type, path:String, identificador:String, complete:  @escaping (T) -> Void) {
        let elPath:String="\(path)/"
        let url = URL(string: "\(baseURL)\(elPath)\(identificador)")
        var request = URLRequest(url: url!)

        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //let data = try! JSONEncoder().encode(post)
       // request.httpBody = data
   
        self.fetch(type: T.self, with: request) { resut in
            switch resut{
            case .success(let post):
                complete(post)
            case .failure(let error):
                print(error)
            }
        }
    }
}
