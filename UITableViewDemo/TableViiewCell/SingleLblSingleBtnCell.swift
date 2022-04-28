//
//  SingleLblSingleBtnCell.swift
//  UITableViewDemo
//
//  Created by ut-i02 on 22/02/2022.
//

import UIKit

class SingleLblSingleBtnCell: UITableViewCell {

    static let Identifier = "SingleLblSingleBtnCell"
    static let NibName = "SingleLblSingleBtnCell"
    static let height: CGFloat = 92
    
    @IBOutlet weak var vwBase: UIView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    private var btnTap: (() -> Void)?  = nil

    static func registerForCell(at: UITableView){
        let cell = UINib(nibName: NibName, bundle: nil)
        at.register(cell, forCellReuseIdentifier: Identifier)
    }
    
    static func getReusableCell(_ tblView: UITableView, indexPath: IndexPath, text: String = "", isAttributed: Bool = false, btnTitle: String = "Button", btnTap: (() -> Void)? = nil) -> SingleLblSingleBtnCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: Identifier, for: indexPath) as! SingleLblSingleBtnCell
        if isAttributed{
            cell.lbl.attributedText = text.htmlToAttributedString
        }else{
            cell.lbl.text = text
        }
        
        cell.btn.setTitle(btnTitle, for: .normal)
        cell.btnTap = btnTap

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
    
    @IBAction func btnTouchUpInside(_ sender: UIButton) {
        if let btnTap = btnTap {
            btnTap()
        }
    }
}
