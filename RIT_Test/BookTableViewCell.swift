//
//  BookTableViewCell.swift
//  RIT_Test
//
//  Created by Alexander Ruduk on 16.07.17.
//  Copyright © 2017 Alexander Ruduk. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var nameBookLabel: UILabel!
    @IBOutlet weak var autorBookLabel: UILabel!
    
    
    func configureCell(book: BookNet) {
        nameBookLabel.text = book.nameBook
        var authors:String = ""
        if book.authorBook != nil {
            for author in book.authorBook! {
                authors += author + "\n"
            }
        }
        autorBookLabel.text = authors
        
        if book.imageURL != nil {
            let imageGoogleURL = URL(string: book.imageURL!)
           bookImage.sd_setImage(with: imageGoogleURL, placeholderImage: #imageLiteral(resourceName: "Open Book"))
        } else {
            bookImage.image = #imageLiteral(resourceName: "Open Book")
        }
        
        bookImage.layer.cornerRadius = bookImage.bounds.size.height / 2
        bookImage.layer.masksToBounds = true
    }
    
    func configureCellCD(book: Book) {
        nameBookLabel.text = book.nameBookCD
        autorBookLabel.text = book.authorBookCD
        
        bookImage.image = UIImage(data: book.imageBookCD! as Data)
        
        bookImage.layer.cornerRadius = bookImage.bounds.size.height / 2
        bookImage.layer.masksToBounds = true
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
