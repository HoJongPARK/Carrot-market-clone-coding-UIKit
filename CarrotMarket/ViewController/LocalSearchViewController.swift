//
//  LocalSearchViewController.swift
//  CarrotMarket
//
//  Created by JongHo Park on 2022/05/26.
//

import UIKit

class LocalSearchViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigationTitle()
  }
  
  private func setNavigationTitle() {
    
  }
  @IBAction func dismiss(_ sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
  }
}
