//
//  File.swift
//  wonderland
//
//  Created by Apple on 2019/11/12.
//  Copyright © 2019 SCUT_wonderland. All rights reserved.
//

import Foundation
import UIKit

let DocumentsDirectory = FileManager()
    .urls(for: .documentDirectory, in: .userDomainMask).first!

let ArticleMetaURL = DocumentsDirectory.appendingPathComponent("articleMeta")
let ArticlesURL = DocumentsDirectory.appendingPathComponent("articles")
