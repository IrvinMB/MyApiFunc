//
//  ViewController.swift
//  MyApiFunc
//
//  Created by Usuario on 19/6/21.
//

import UIKit

class ViewController: UIViewController {
    var cliente:Client?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cliente = Client()
        // Do any additional setup after loading the view.
    }

    @IBAction func GET(_ sender: Any) {
        cliente?.getList(type: [Posts].self, path:"posts", complete: {result in
            switch result {
                case .success(let posts):
                    print(posts)
                 
                case .failure(let error):
                    print(error)
               }
        })
    }
    
    @IBAction func Push(_ sender: Any) {
        let elPosts = Posts(id: 99, title: "Prueba")
        self.cliente?.postJson(post: elPosts,path:"posts",complete: { elResultPost  in
            print(elResultPost)
        })
    }
    
    @IBAction func Put(_ sender: Any) {
        let elPosts = Posts(id: 1, title: "Prueb1")
        self.cliente?.PutJson(post: elPosts,path:"posts", identificador: "\(elPosts.id)" ,complete: { elResultPost  in
            print("Se actualiza el id \(elResultPost.id) \(elResultPost)")
        })
    }
    
    @IBAction func Delete(_ sender: Any) {
        self.cliente?.DeleteJson(type: [Posts].self, path:"posts", identificador: "1",complete: { elResultPost  in
            print("SE elimina el id 1 \(elResultPost)")
        })
    }
}

