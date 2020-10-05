//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

class ViewController: UIViewController {
    
    var verticalStackView: UIStackView!
    var buttons: [UIButton]!
    var horizontalStackViews: [UIStackView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        horizontalStackViews = [UIStackView]()
        buttons = [UIButton]()
        view.backgroundColor = .green
        view.addSubview(verticalStackView)
        creatingArrayOfButtons(count: 10000)
        creatingArrayOfStacks(stacks: 100, buttons: 100)
        horizontalStackViews.forEach{stack in verticalStackView.addArrangedSubview(stack)}
        constraintsForStack()
    }
    
    func creatingArrayOfButtons(count: Int) {
        for _ in 1...count {
            let newButton = UIButton(type: .system)
            newButton.backgroundColor = UIColor.random
            buttons.append(newButton)
        }
    }
    
    func creatingArrayOfStacks(stacks: Int, buttons: Int) {
        for _ in 1...stacks {
            let newStack = UIStackView()
            newStack.axis = .horizontal
            newStack.spacing = 0
            newStack.distribution = .fillEqually
            horizontalStackViews.append(newStack)
        }
        fillStackWithButtons(buttonsInEach: buttons)
    }
    
    func fillStackWithButtons(buttonsInEach: Int){
        horizontalStackViews.forEach{ stack in
            for _ in 1...buttonsInEach {
                if let currentButton = buttons.first{
                    stack.addArrangedSubview(currentButton)
                    buttons.removeFirst()
                }
            }
        }
    }
    
    func constraintsForStack() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 0
        verticalStackView.distribution = .fillEqually
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
            verticalStackView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 100),
            verticalStackView.heightAnchor.constraint(equalToConstant: 600),
            verticalStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100)
        ])
    }
}
extension CGFloat {
    static var random: CGFloat {
           return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static var random: UIColor {
           return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
}
PlaygroundPage.current.liveView = ViewController()

//private func makeABCbtns(){
//
//    let list = [["A", "B", "C", "D", "E"], ["F", "G", "H", "I", "J"], ["K","L", "M", "N", "O"], ["P", "Q","R", "S", "T"], ["U", "V", "W","X", "Y"], ["Z"]]
//    var groups = [UIStackView]()
//
//    for i in list {
//        let group = createButtons(named: i)
//        let subStackView = UIStackView(arrangedSubviews: group)
//        subStackView.axis = .horizontal
//        subStackView.distribution = .fillEqually
//        subStackView.spacing = 1
//        groups.append(subStackView)
//    }
//
//    let stackView = UIStackView(arrangedSubviews: groups)
//    stackView.axis = .vertical
//    stackView.distribution = .fillEqually
//    stackView.spacing = 1
//    stackView.translatesAutoresizingMaskIntoConstraints = false
//
//    abcBtnView.addSubview(stackView)
//
//    stackView.leadingAnchor.constraint (equalTo: abcBtnView.leadingAnchor,  constant: 0).isActive = true
//    stackView.topAnchor.constraint     (equalTo: abcBtnView.topAnchor,      constant: 0).isActive = true
//    stackView.trailingAnchor.constraint(equalTo: abcBtnView.trailingAnchor, constant: 0).isActive = true
//    stackView.bottomAnchor.constraint  (equalTo: abcBtnView.bottomAnchor,   constant: 0).isActive = true
//}
//
//func createButtons(named: [String]) -> [UIButton]{
//    return named.map { letter in
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle(letter, for: .normal)
//        button.backgroundColor = .green
//        button.setTitleColor( .blue , for: .normal)
//        return button
//    }
//}
//}
//Result
//        verticalStackView.leadingAnchor.constraint (equalTo: view.leadingAnchor,  constant: 0).isActive = true
//        verticalStackView.topAnchor.constraint     (equalTo: view.topAnchor,      constant: 0).isActive = true
//        verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
//        verticalStackView.bottomAnchor.constraint  (equalTo: view.bottomAnchor,   constant: 0).isActive = true

//  var loginButton: UIButton!
//  var nameTextField: UITextField!
//  var passwordTextField: UITextField!
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    view.backgroundColor = .white
//
//    loginButton = UIButton(type: .system)
//    loginButton.setTitle("Login", for: .normal)
//    loginButton.translatesAutoresizingMaskIntoConstraints = false
//    view.addSubview(loginButton)
//    loginButton.addTarget(self, action: #selector(handleLoginTouchUpInside), for: .touchUpInside)
//
//    nameTextField = UITextField(frame: .zero)
//    nameTextField.placeholder = "Login Name"
//    nameTextField.borderStyle = .roundedRect
//    nameTextField.translatesAutoresizingMaskIntoConstraints = false
//    view.addSubview(nameTextField)
//
//    passwordTextField = UITextField(frame: .zero)
//    passwordTextField.placeholder = "Password"
//    passwordTextField.isSecureTextEntry = true
//    passwordTextField.borderStyle = .roundedRect
//    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
//    view.addSubview(passwordTextField)
//
//    constraintsInit()
//  }
//
//  func constraintsInit() {
//    NSLayoutConstraint.activate([
//      loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//      loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//
//      passwordTextField.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -20),
//      passwordTextField.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 20),
//      passwordTextField.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -20),
//
//      nameTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -20),
//      nameTextField.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 20),
//      nameTextField.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -20)
//    ])
//  }
//
//  @objc func handleLoginTouchUpInside() {
//    print("Login has been tapped")
//    if nameTextField.isFirstResponder {
//      nameTextField.resignFirstResponder()
//    }
//    if passwordTextField.isFirstResponder {
//      passwordTextField.resignFirstResponder()
//    }
//  }
//}
// Present the view controller in the Live View window
