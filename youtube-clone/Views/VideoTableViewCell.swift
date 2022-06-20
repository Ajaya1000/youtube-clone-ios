//
//  VideoTableViewCell.swift
//  youtube-clone
//
//  Created by Ajaya Mati on 20/06/22.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var thumnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var video:Video?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ v:Video){
        self.video = v
        
        guard self.video != nil else {
            return
        }
        
        //set the title
        self.titleLabel.text = video?.title
        
        
        // set the date
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        self.dateLabel.text = df.string(from: video!.published)
        
        guard self.video?.thumbnail != "" else{
            return
        }
        
        //check cache before downloading the data
        if let cachedData = CacheManager.getVideoCache(self.video!.thumbnail) {
            self.thumnailImageView.image = UIImage(data: cachedData)
            return
        }
        
        //Download the thumbnail data
        
        let url = URL(string: self.video!.thumbnail)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
            guard error == nil && data != nil else{
                return
            }
                
                // store dat to cache manager
                CacheManager.setVideoCache(self.video!.thumbnail, data!)
                
                //check that the downloaded url matches the video thumbnail url that this cell is currently set to display
                if url!.absoluteString != self.video?.thumbnail{
                    
                    //Video Cell has been recycled for another video and no longer matches the thumbnail that has been downloaded
                    return
                }
                

                
                // create image object
                // set the image view
                
                let image = UIImage(data: data!)
                
                DispatchQueue.main.async {
                    self.thumnailImageView.image = image
                }
            }
        
        // start the data task
        dataTask.resume()
        
    }

}
