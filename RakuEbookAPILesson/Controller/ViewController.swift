//
//  ViewController.swift
//  RakuEbookAPILesson
//
//  Created by UrataHiroki on 2021/11/09.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var resultTableView: UITableView!
    
    private let alamofireProcess = AlamofireProcess()
    
    private var cellContentsArray = [EbookDetailDatas]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        resultTableView.register(UINib(nibName: "TableViewCutomCell", bundle: nil), forCellReuseIdentifier: "EbookDetailCell")
        resultTableView.delegate = self
        resultTableView.dataSource = self
        
    }

    @IBAction func search(_ sender: UIButton) {
        
        alamofireProcess.getEbookDetailData(searchKeyWord: searchTextField.text) { result, error in
            
            if error != nil{
                
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {[self] in
                
                cellContentsArray = result!
                resultTableView.reloadData()
            }
        }
    }
    
}

extension ViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.height / 3.5
    }

}

extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellContentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EbookDetailCell", for: indexPath) as! TableViewCutomCell
        
        cell.mediumImageView.sd_setImage(with: URL(string: cellContentsArray[indexPath.row].mediumImageUrl!), completed: nil)
        cell.titleLabel.text = cellContentsArray[indexPath.row].title
        cell.authorLabel.text = cellContentsArray[indexPath.row].author
        cell.itemCaptionTextView.text = cellContentsArray[indexPath.row].itemCaption
        
        return cell
    }
}


