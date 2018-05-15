//
//  FeedVC.swift
//  BreakpointApp_Firebase
//
//  Created by Nguyen Hieu Trung on 5/10/18.
//  Copyright © 2018 NHTSOFT. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    @IBOutlet weak var tableFeed: UITableView!
    var arrayFeed = [Message]();
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableFeed.delegate = self;
        self.tableFeed.dataSource = self;
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        DataService.instant.getAllFeedMessage { (message) in
            self.arrayFeed = message;
            self.tableFeed.reloadData();
        }
        
    }
    
}

extension FeedVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFeed.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("ARRAYFEED: \(self.arrayFeed.count)");
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedReuseCell", for: indexPath) as? FeedCell else{return UITableViewCell()};
        
        let msgFeed = self.arrayFeed[indexPath.row];
        print("ARRAYFEED: \(msgFeed.content)");
        let image = UIImage(named: "defaultProfileImage");
        DataService.instant.getUserName(forUID: msgFeed.senderID) { (userName) in
            cell.configCell(image:  image!, email: userName, message: msgFeed.content);
        }
        
        
        
        
        return cell;
    }
    
    
}
