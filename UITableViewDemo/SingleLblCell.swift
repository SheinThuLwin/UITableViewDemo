//
//  SingleLblCell.swift
//  UITableViewDemo
//
//  Created by ut-i02 on 22/02/2022.
//

import UIKit

class SingleLblCell: UITableViewCell {
    
    static let Identifier = "SingleLblCell"
    static let NibName = "SingleLblCell"
    static let height: CGFloat = 53
    
    @IBOutlet weak var vwBase: UIView!
    @IBOutlet weak var lbl: UILabel!

    static func registerForCell(at: UITableView){
        let cell = UINib(nibName: NibName, bundle: nil)
        at.register(cell, forCellReuseIdentifier: Identifier)
    }
    
    static func getReusableCell(_ tblView: UITableView, indexPath: IndexPath, text: String = "") -> SingleLblCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: Identifier, for: indexPath) as! SingleLblCell
        cell.lbl.text = text

        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
