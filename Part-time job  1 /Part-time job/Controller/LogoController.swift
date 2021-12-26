//
//  File.swift
//  DO IT Welcom
//
//  Created by ABRAR ALQARNI on 05/05/1443 AH.
//


import UIKit
//    let parent = UIViewController()
//    child.view.translatesAutoresizingMaskIntoConstraints = false
//    child.view.frame = parent.view.bounds
//    parent.view.addSubview(child.view)
//    parent.addChild(child)
////
//struct LogoController: View {
//  @State private var animated: Bool = false
//  var body: some View{
//    ZStack{
//      Image("logo")
//        .resizable()
//        .frame(width: 150, height: 150)
//
//    }
//    VStack {
//      HStack{
//        Spacer()
//
//        ZStack(alignment: .bottom){
//          VStack(alignment: .leading, spacing: 20) {
//            Text("Welcom")
//              .font(.title)
//              .fontWeight(.semibold)
//              .padding(.top, 20)
//
//            Text("Hi")
//
//            HStack{
//              Button(action: {}) {
//                Text("Sign in")
//                  .padding(20)
//                  .foregroundColor(.black)
//                  .background(Color.white)
//                  .clipShape(Capsule())
//              }
//              Button(action: {}) {
//                Text("Sign up")
//                  .padding(20)
//                  .foregroundColor(.white)
//                  .background(Color.black)
//                  .clipShape(Capsule())
//              }
//              Spacer()
//            }
//          }
//        }
//      }
//    }
//  }
//
//}
//
//struct LogoController_Previews : PreviewProvider {
//  static var previews: some View{
//
//    LogoController()
//  }
//
//
//}
//var child = UIHostingController(rootView: LogoController())
class LogoController: UIViewController {
  
  
  private let imageView : UIImageView = {
    let imageView  = UIImageView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: 150,
                                               height: 150))
    imageView.image = UIImage(named: "logo")
    return imageView
  }()
  
  override func viewWillLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    imageView.center = view.center
    DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
      self.animate()
    })
    view.addSubview(imageView)
    
  }
  
  private func animate() {
    UIView.animate(withDuration: 1, animations: {
      let size = self.view.frame.size.width * 2
      let diffX = size - self.view.frame.size.width
      let diffY = self.view.frame.size.height - size
      
      self.imageView.frame = CGRect(x: -(diffX/2),
                                    y: diffY/2,
                                    width: size,
                                    height: size)
    })
    
    UIView.animate(withDuration: 1.5, animations: {
      self.imageView.alpha = 0
      
    })
  }
  
}
