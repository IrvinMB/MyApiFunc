Skip to content
John Codeos
Home
Tutorials
Contact

 

How to make POST, GET, PUT and DELETE requests with URLSession using Swift
March 8, 2020 by John Codeos
In this tutorial, I’m going to show you how to use all HTTP methods (GET, POST, PUT, DELETE) using URLSession on iOS.

Adding data using POST method
If you want to send data to the server, as we do in this example by uploading an employee’s data(name, salary, and age) to the database, then use the HTTP method POST.

In this example, the data we have to upload need to be in the following JSON format:

{
  "age" : "23",
  "name" : "Jack",
  "salary" : "3540"
}
Code language: Swift (swift)
When you send JSON data, define it on your request by adding application/json as Content-Type in the HTTP Header.

func postMethod() {
        guard let url = URL(string: "http://dummy.restapiexample.com/api/v1/create") else {
            print("Error: cannot create URL")
            return
        }
        
        // Create model
        struct UploadData: Codable {
            let name: String
            let salary: String
            let age: String
        }
        
        // Add data to the model
        let uploadDataModel = UploadData(name: "Jack", salary: "3540", age: "23")
        
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Couldn't print JSON in String")
                    return
                }
                
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
Code language: Swift (swift)

 
Retrieving data using GET method
Use the HTTP method GET to retrieve information from REST API, like user info in a social media API (e.g. Facebook Graph API)

func getMethod() {
        guard let url = URL(string: "http://dummy.restapiexample.com/api/v1/employees") else {
            print("Error: cannot create URL")
            return
        }
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Could print JSON in String")
                    return
                }
                
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
Code language: Swift (swift)
Updating data using PUT method
If you have the data already, and you want to update them, you can use the HTTP method PUT. Sometimes you can do the same with the POST method.

This method will replace the previous data with the new ones.

func putMethod() {
        guard let url = URL(string: "https://reqres.in/api/users/2") else {
            print("Error: cannot create URL")
            return
        }
        
        // Create model
        struct UploadData: Codable {
            let name: String
            let job: String
        }
        
        // Add data to the model
        let uploadDataModel = UploadData(name: "Nicole", job: "iOS Developer")
        
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling PUT")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Could print JSON in String")
                    return
                }
                
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
Code language: Swift (swift)

 
Removing data using DELETE method
Remove data from your REST API server using the HTTP method DELETE.

func deleteMethod() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else {
            print("Error: cannot create URL")
            return
        }
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling DELETE")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Could print JSON in String")
                    return
                }
                
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
Code language: Swift (swift)
In this example, the URL I’m using for the DELETE method doesn’t return any response after deleting the item. That’s why the results are empty.

You can find the final project here
If you have any questions, please feel free to leave a comment below

Share this post:
Share on Twitter    Share on Facebook    Share on Pinterest    Share on LinkedIn    Share on Reddit    Share on Email
CategoriesiOS
TagsHTTP, iOS, Networking, Swift, URLSession

 
 Subscribe
Connect withD
guest



0 COMMENTS

 
Follow me on socials
Popular Posts

How to make POST, GET, PUT and DELETE requests with Retrofit using Kotlin

How to create a Side Menu in iOS using Swift

How to change your Project Name & Package Name in Android Studio

How to add Search in RecyclerView using Kotlin

How to create Bottom Navigation Bar with Jetpack Compose

How to parse JSON in Android using Kotlin

 

 
© 2021 John Codeos. All rights reserved (lefts too)
 
