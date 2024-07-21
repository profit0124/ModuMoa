//
//  CGSize+.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/21/23.
//

import Foundation

extension CGSize {
  static func + (lhs: Self, rhs: Self) -> Self {
    CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
  }
}
