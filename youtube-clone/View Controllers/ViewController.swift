//
//  ViewController.swift
//  youtube-clone
//
//  Created by Ajaya Mati on 16/06/22.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,ModelDelagate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var model = Model()
    var videos = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set itself as the dataSource and delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        //set itself the delegate
        model.delegate = self
        
        model.getVideos()
    }
    
    // MARK: - Model delegate methods
    
    func videosFetched(_ videos: [Video]) {
        self.videos = videos
        self.tableView.reloadData()
    }
    
    // MARK: - Table View Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID, for: indexPath) as! VideoTableViewCell
        
        let video = self.videos[indexPath.row]
        
        cell.setCell(video)
        
        return cell
    }
    
    
    

}

