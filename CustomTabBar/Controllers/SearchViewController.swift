//
//  SearchViewController.swift
//  BicycleApp
//
//  Created by Shi Pra on 29/09/22.
//

import UIKit

class SearchViewController: DefaultViewController {

    let navTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 24)
        title.textColor = UIColor.white
        title.text = "Search"
        return title
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.anchorBackgroundTriangle()
        view.addSubview(navTitle)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        navTitle.center(inView: view)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
