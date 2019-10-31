//
//  GigController.swift
//  ios-gigs
//
//  Created by John Pitts on 5/16/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import Foundation

class GigController {
    
    private let baseURL = URL(string: "https://lambdagigs.vapor.cloud/api")!
    
    func signUp(with username: String, password: String, completion: @escaping (Error?) -> Void) {
        
        //Set up the URL & URLRequest
        let requestURL = baseURL.appendingPathComponent("users/signup")
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = HTTPMethod.post.rawValue
        
        // The body of our request is JSON.
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let user = User(username: username, password: password)
        
        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            NSLog("Error encoding User: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {                                 //then... Something went wrong
                completion(NSError())
                return
            }
            if let error = error {
                NSLog("Error signing up: \(error)")
                completion(error)
                return
            }
            completion(nil)
            }.resume()
    } // end signing UP
    
    
    func logIn(with username: String, password: String, completion: @escaping (Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("users/login")
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = HTTPMethod.post.rawValue
        
        // The body of our request is JSON.
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let user = User(username: username, password: password)                  // prepare the body before encoding
        
        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            NSLog("Error encoding User: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                // Something went wrong
                completion(NSError())
                return
            }
            if let error = error {
                NSLog("Error logging in: \(error)")
                completion(error)
                return
            }
            // Get the bearer token by decoding it.
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let bearer = try decoder.decode(Bearer.self, from: data)     // Bearer.self means a TYPE; .self says Bearer-type
                
                // save the bearer to your model object instance
                self.bearer = bearer
                completion(nil)
            } catch {
                NSLog("Error decoding Bearer: \(error)")
                completion(error)
                return
            }
            }.resume()
    }
    
    func getAllGigs(completion: @escaping (Result<[Gig], NetworkError>) -> Void) {
        
        guard let bearer = bearer else {
            NSLog("No bearer token available")
            completion(.failure(.noBearer))   //.failure is a property/method of Result & .noBearer is error name we created
            return
        }
        
        let requestURL = baseURL.appendingPathComponent("gigs")
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        // If the method is GET, there is no body
        // Authenticate
        request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization") // changed addValue to setValue just in case
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {                 // or you could write != 200
                completion(Result.failure(.badAuth))        // can i get away with Result.failure long form here?
                return
            }
            
            if let error = error {
                NSLog("Error getting animal names: \(error)")
                completion(.failure(.apiError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noDataReturned))
                return
            };  print("data exists!")
            
            let decoder = JSONDecoder()
            
            do {
                let gigs = try decoder.decode([Gig].self, from: data)
                completion(.success(gigs))
            } catch {
                NSLog("Error decoding gigs: \(error)")
                completion(.failure(.noDecode))
            }
            }.resume()
    }
    
    // write create gig func
    func post(title: String, description: String, dueDate: Date, completion: @escaping (Result<Gig, NetworkError>) -> Void) {
        
        guard let bearer = bearer else {
            NSLog("No bearer token available")
            completion(.failure(.noBearer))   //.failure is a property/method of Result & .noBearer is error name we created
            return
        }

        let requestURL = baseURL.appendingPathComponent("gigs")  //changed var to let
        
        var request = URLRequest(url: requestURL)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = HTTPMethod.post.rawValue
        
        let gig = Gig(title: title, description: description, dueDate: dueDate)
        
        do {
            let jsonEncoder = JSONEncoder()
            
            request.httpBody = try jsonEncoder.encode(gig) // Turns a gig -> Data
        } catch {
            NSLog("Error encoding task: \(error)")
        }
        
        
        // this whole call is dicked up!
        
        
        
        
        
        
         request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")   // in correct spot? bearer used.
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {                 // or you could write != 200
                completion(Result.failure(.badAuth))        // can i get away with Result.failure long form here?
                return
            }
            
            if let error = error {
                NSLog("Error posting to api: \(error)")
                completion(.failure(.apiError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noDataReturned))
                return
            };  print("gig going!")
            
            do {
                let jsonDecoder = JSONDecoder()
                let gigs = try jsonDecoder.decode([Gig].self, from: data)
                self.gigs = gigs
                completion(gigs, nil)
                
            } catch {
                NSLog("Error decoding data from json to model [Gig] \(NSError())")
                completion(nil, NSError)
            }
        }.resume()
    }
    
    
    
    
    enum NetworkError: Error {
        case noDataReturned
        case noBearer
        case badAuth
        case apiError
        case noDecode
    }
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    var bearer: Bearer?
    var gigs: [Gig] = []
}
