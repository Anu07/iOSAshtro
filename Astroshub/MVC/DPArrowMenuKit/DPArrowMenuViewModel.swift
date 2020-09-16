//
//  DPArrowMenuViewModel.swift
//  DPArrowMenu
//
//  Created by Hongli Yu on 19/01/2017.
//  Copyright © 2017 Hongli Yu. All rights reserved.
//

import Foundation

public class DPArrowMenuViewModel {
    
  var title: String?
  var id: String?
  var imageName: String?
    
  public init(title: String, imageName: String, id: String) {
    self.title = title
    self.id = id
    self.imageName = imageName
  }
//    public init(title: String) {
//      self.title = title
//     // self.imageName = imageName
//    }
    
}
