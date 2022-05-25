//
//  SelectIntervieweeModalVC.swift
//  InterviewApp
//
//  Created by Valya on 21.05.22.
//

import UIKit

class SelectIntervieweeModalVC: UIViewController {

    weak var delegate: PlanNewInterviewVCDelegate?
        
        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Select interviewee"
            label.font = .boldSystemFont(ofSize: 25)
            return label
        }()
    
        lazy var titleLabelNewInterviewee: UILabel = {
            let label = UILabel()
            label.text = "New interviewee"
            label.font = .boldSystemFont(ofSize: 25)
            return label
        }()
    
        lazy var pickerView: UIPickerView = {
            let pickerView = UIPickerView()
            pickerView.delegate = self
            pickerView.dataSource = self
            return pickerView
        }()
    
        lazy var buttonShowAllVC: UIButton = {
            let button = UIButton()
            button.setTitle("... or you can create a new interviewee", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.frame = CGRect(x: 20, y: -15, width: 300, height: 30)
            button.backgroundColor = .white
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor(red: 0 / 255, green: 99 / 255, blue: 193 / 255, alpha: 1).cgColor
            button.layer.cornerRadius = 22
            button.addTarget(self, action: #selector(showFullModalView(sender:)), for: .touchUpInside)
            return button
        }()
    
        lazy var nameTextField: CustomTextFields = {
            let textField = CustomTextFields()
            textField.customTextFieldTitle = "Name"
            return textField
        }()
    
        lazy var emailTextField: CustomTextFields = {
            let textField = CustomTextFields()
            textField.customTextFieldTitle = "Email"
            return textField
        }()
    
        lazy var phoneTextField: CustomTextFields = {
            let textField = CustomTextFields()
            textField.customTextFieldTitle = "Phone"
            return textField
        }()
    
        lazy var notesTextField: CustomTextFields = {
            let textField = CustomTextFields()
            textField.customTextFieldTitle = "any other notes"
            return textField
        }()
    
        lazy var createIntervieweeBtn: UIButton = {
            let button = UIButton()
            button.setTitle("Create", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.frame = CGRect(x: 20, y: -15, width: 300, height: 30)
            button.backgroundColor = UIColor(red: 0 / 255, green: 99 / 255, blue: 193 / 255, alpha: 1)
            button.layer.cornerRadius = 22
            button.addTarget(self, action: #selector(createNewInterviewee(sender:)), for: .touchUpInside)
            return button
        }()
    
        
        lazy var contentStackView: UIStackView = {
            let spacer = UIView()
            let stackView = UIStackView(arrangedSubviews: [titleLabel, pickerView, buttonShowAllVC, spacer])
            stackView.axis = .vertical
            stackView.spacing = 12.0
            return stackView
        }()
    
        lazy var addIntervieweeStackView: UIStackView  = {
            let spacer = UIView()
            let stackView = UIStackView(arrangedSubviews: [titleLabelNewInterviewee, nameTextField, emailTextField, phoneTextField, notesTextField, createIntervieweeBtn, spacer])
            stackView.axis = .vertical
            stackView.spacing = 20
            return stackView
        }()
        
        lazy var containerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 16.0
            view.clipsToBounds = true
            return view
        }()

        let maxDimmedAlpha: CGFloat = 0.6
        lazy var dimmedView: UIView = {
            let view = UIView()
            view.backgroundColor = .black
            view.alpha = maxDimmedAlpha
            return view
        }()
        
        // Constants
        let defaultHeight: CGFloat = 300
        let dismissibleHeight: CGFloat = 200
        let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
        // keep current new height, initial is default height
        var currentContainerHeight: CGFloat = 300
    
        var interviewees: [Interviewee]?
        
        // Dynamic container constraint
        var containerViewHeightConstraint: NSLayoutConstraint?
        var containerViewBottomConstraint: NSLayoutConstraint?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupView()
            setupConstraints()
            // tap gesture on dimmed view to dismiss
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
            dimmedView.addGestureRecognizer(tapGesture)
            
            setupPanGesture()
            
//            self.pickerView.delegate = self
//            self.pickerView.dataSource = self
        }
        
        @objc func handleCloseAction() {
            animateDismissView()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            animateShowDimmedView()
            animatePresentContainer()
        }
    
        @objc private func showFullModalView(sender: UIButton!) {
            animateContainerHeight(maximumContainerHeight)
        }
    
        @objc private func createNewInterviewee(sender: CustomButtons!) {
            animateContainerHeight(currentContainerHeight)
        }
        
        func setupView() {
            view.backgroundColor = .clear
        }
            
        func setupConstraints() {
            // Add subviews
            view.addSubview(dimmedView)
            view.addSubview(containerView)
            dimmedView.translatesAutoresizingMaskIntoConstraints = false
            containerView.translatesAutoresizingMaskIntoConstraints = false
            
            containerView.addSubview(contentStackView)
            containerView.addSubview(addIntervieweeStackView)
            contentStackView.translatesAutoresizingMaskIntoConstraints = false
            addIntervieweeStackView.translatesAutoresizingMaskIntoConstraints = false
            
            // Set static constraints
            NSLayoutConstraint.activate([
                // set dimmedView edges to superview
                dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
                dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                // set container static constraint (trailing & leading)
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                // content stackView
                contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
//                contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
                contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
                contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
                addIntervieweeStackView.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 0),
                addIntervieweeStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
                addIntervieweeStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:-40),
                pickerView.heightAnchor.constraint(equalToConstant: 100),
                buttonShowAllVC.heightAnchor.constraint(equalToConstant: 45),
                nameTextField.heightAnchor.constraint(equalToConstant: 45),
                emailTextField.heightAnchor.constraint(equalToConstant: 45),
                phoneTextField.heightAnchor.constraint(equalToConstant: 45),
                notesTextField.heightAnchor.constraint(equalToConstant: 45),
                createIntervieweeBtn.heightAnchor.constraint(equalToConstant: 45),
                contentStackView.heightAnchor.constraint(equalToConstant: 270)
            ])
            
            // Set dynamic constraints
            // First, set container to default height
            // after panning, the height can expand
            containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
            
            // By setting the height to default height, the container will be hide below the bottom anchor view
            // Later, will bring it up by set it to 0
            // set the constant to default height to bring it down again
            containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
            // Activate constraints
            containerViewHeightConstraint?.isActive = true
            containerViewBottomConstraint?.isActive = true
        }
        
        func setupPanGesture() {
            // add pan gesture recognizer to the view controller's view (the whole screen)
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
            // change to false to immediately listen on gesture movement
            panGesture.delaysTouchesBegan = false
            panGesture.delaysTouchesEnded = false
            view.addGestureRecognizer(panGesture)
        }
        
        // MARK: Pan gesture handler
        @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
            let translation = gesture.translation(in: view)
            // Drag to top will be minus value and vice versa
            print("Pan gesture y offset: \(translation.y)")
            
            // Get drag direction
            let isDraggingDown = translation.y > 0
            print("Dragging direction: \(isDraggingDown ? "going down" : "going up")")
            
            // New height is based on value of dragging plus current container height
            let newHeight = currentContainerHeight - translation.y
            
            // Handle based on gesture state
            switch gesture.state {
            case .changed:
                // This state will occur when user is dragging
                if newHeight < maximumContainerHeight {
                    // Keep updating the height constraint
                    containerViewHeightConstraint?.constant = newHeight
                    // refresh layout
                    view.layoutIfNeeded()
                }
            case .ended:
                // This happens when user stop drag,
                // so we will get the last height of container
                
                // Condition 1: If new height is below min, dismiss controller
                if newHeight < dismissibleHeight {
                    self.animateDismissView()
                }
                else if newHeight < defaultHeight {
                    // Condition 2: If new height is below default, animate back to default
                    animateContainerHeight(defaultHeight)
                }
                else if newHeight < maximumContainerHeight && isDraggingDown {
                    // Condition 3: If new height is below max and going down, set to default height
                    animateContainerHeight(defaultHeight)
                }
                else if newHeight > defaultHeight && !isDraggingDown {
                    // Condition 4: If new height is below max and going up, set to max height at top
                    animateContainerHeight(maximumContainerHeight)
                }
            default:
                break
            }
        }
        
        func animateContainerHeight(_ height: CGFloat) {
            UIView.animate(withDuration: 0.4) {
                // Update container height
                self.containerViewHeightConstraint?.constant = height
                // Call this to trigger refresh constraint
                self.view.layoutIfNeeded()
            }
            // Save current height
            currentContainerHeight = height
        }
        
        // MARK: Present and dismiss animation
        func animatePresentContainer() {
            // update bottom constraint in animation block
            UIView.animate(withDuration: 0.3) {
                self.containerViewBottomConstraint?.constant = 0
                // call this to trigger refresh constraint
                self.view.layoutIfNeeded()
            }
        }
        
        func animateShowDimmedView() {
            dimmedView.alpha = 0
            UIView.animate(withDuration: 0.4) {
                self.dimmedView.alpha = self.maxDimmedAlpha
            }
        }
        
        func animateDismissView() {
            // hide blur view
            dimmedView.alpha = maxDimmedAlpha
            UIView.animate(withDuration: 0.4) {
                self.dimmedView.alpha = 0
            } completion: { _ in
                // once done, dismiss without animation
                self.dismiss(animated: false)
            }
            // hide main view by updating bottom constraint in animation block
            UIView.animate(withDuration: 0.3) {
                self.containerViewBottomConstraint?.constant = self.defaultHeight
                // call this to trigger refresh constraint
                self.view.layoutIfNeeded()
            }
        }
}

extension SelectIntervieweeModalVC:  UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        interviewees![row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        interviewees!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.updateSelectedInterviewee(interviewee: interviewees![row])
    }
    
}
