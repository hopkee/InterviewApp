//
//  IntervieweeCell.swift
//  InterviewApp
//
//  Created by Валентин Величко on 11.05.22.
//

import UIKit

class IntervieweeCell: UITableViewCell {
    
    @IBOutlet weak var intervieweeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
