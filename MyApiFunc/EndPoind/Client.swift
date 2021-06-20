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
    
    init(session: URLSession) {
        self.session = session
    }
    
    func getList<T: Decodable>(type:T.Type,path:String,complete: @escaping (Result<T, ApiError>) -> Void) {
        let url = URL(string: "\(baseURL)\(path)")
        let request = URLRequest(url: url!)
        self.fetch(type: T.self, with: request, completion: complete)
    }
    func getComments<T: Decodable>(type:T.Type, parametros:[String:Any]? ,complete: @escaping (Result<T, ApiError>) -> Void) {
        var path = "comments"
        if (parametros!.count > 0) {
            path="\(path)?"
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
}
