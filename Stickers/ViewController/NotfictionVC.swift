//
//  NotfictionVC.swift
//  Stickers
//
//  Created by  Ahmed’s MacBook Pro on 3/12/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import DateToolsSwift
import MBProgressHUD
import Alamofire


class NotfictionVC: UIViewController {

    @IBOutlet weak var Table: UITableView!
    
    fileprivate var notifctiondata:[Notifiction] = []


    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNotfiction()
        setupview()

    }
    
    func setupview(){
        let nib = UINib(nibName: "NotfictionsCell", bundle: nil)
        Table.register(nib, forCellReuseIdentifier: "NotfictionsCell")
        self.navigationItem.title = "اشعارات"


    }
    
    
    func getNotfiction(){
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = "Loading"
        hud.mode = .indeterminate
        hud.removeFromSuperViewOnHide = true
        WebServices.getnotifiction { (item, error) in
            guard let item = item else {
                hud.mode = .text
                hud.label.text = "Error"
                hud.detailsLabel.text =  "Something went wrong!"
               
                hud.hide(animated: true, afterDelay: 2.0)
                return
            }
            hud.hide(animated: true)
            self.notifctiondata.append(contentsOf: item)
            self.Table.reloadData()
        }
    }
    


}
extension NotfictionVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifctiondata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let deatilesnotfiction = notifctiondata[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotfictionsCell", for: indexPath) as! NotfictionsCell
        cell.message_notifiction.text = deatilesnotfiction.message
        cell.created_at.text = deatilesnotfiction.created_at?.timeAgoSinceNow
        
        
        return cell
    }
    
    
    
    
    
    
}
