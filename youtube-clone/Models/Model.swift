//
//  Model.swift
//  youtube-clone
//
//  Created by Ajaya Mati on 16/06/22.
//

import Foundation

protocol ModelDelagate {
    func videosFetched(_ videos:[Video])
}

class Model{
    
    var delegate: ModelDelagate?
    
    func getVideos(){
        //create a URL object
        
        let url = URL(string: Constants.API_URL)
        
        guard url != nil else{
            return
        }
        
        // Get a URL Session Object
        
        let session = URLSession.shared
        
        // Get a data task from the URLSession object
        let dataTask = session.dataTask(with: url!) {data, response, error in
            
            //check if there's any error
            
            if error != nil || data == nil {
                return
            }
            
            do{
                //Parsing the data video objects
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response = try decoder.decode(Response.self, from: data!)
                dump(response)
                
                if let videos = response.items{
                    DispatchQueue.main.async {
                        self.delegate?.videosFetched(videos)
                    }
                    
                }
                
            }catch{
                print("seomthing is wrong")
            }
          
            
        }
        //Kick off your task
        
        dataTask.resume()
    }
}
