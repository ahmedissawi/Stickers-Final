//
//  NotfictionsCell.swift
//  Stickers
//
//  Created by  Ahmed’s MacBook Pro on 3/12/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit

class NotfictionsCell: UITableViewCell {
    
    @IBOutlet weak var message_notifiction: UILabel!
    
    @IBOutlet weak var created_at: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
