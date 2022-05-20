//
//  InterviewCell.swift
//  InterviewApp
//
//  Created by Valya on 7.05.22.
//

import UIKit

class InterviewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundOutlet: UIView!
    @IBOutlet weak var nameOfInterviewLblOutlet: UILabel!
    @IBOutlet weak var nameOfIntervieweeOutlet: UILabel!
    @IBOutlet weak var dateOfInterviewOutlet: UILabel!
    @IBOutlet weak var audioIconOutlet: UIImageView!
    @IBOutlet weak var textIconOutlet: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    override var frame: CGRect {
            get {
                return super.frame
            }
            set (newFrame) {
                var frame = newFrame
                let newWidth = frame.width * 0.95
                let space = (frame.width - newWidth) / 2
                frame.size.width = newWidth
                frame.origin.x += space

                super.frame = frame

            }
        }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setUpUI() {
        backgroundOutlet.clipsToBounds = true
        backgroundOutlet.layer.cornerRadius = 15
    }
    
}
