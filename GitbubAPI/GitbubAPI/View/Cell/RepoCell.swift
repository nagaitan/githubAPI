//
//  RepoCell.swift
//  GitbubAPI
//
//  Created by Adi Wibowo on 25/05/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import UIKit
import AlamofireImage

class RepoCell: UITableViewCell {
    @IBOutlet weak var imgRepo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblStar: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(repo : Repository) {
        lblTitle.text = repo.name
        lblDesc.text = repo.description
        lblStar.text = "\(repo.starsCount) Stars"
        let urlImage = repo.owner.avatarUrl
        
        if let url = NSURL(string: urlImage){
            imgRepo.af_setImage(withURL: url as URL, placeholderImage: nil, filter: nil, progress: nil, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: true, completion: nil)
        }
        
    }
    
}
