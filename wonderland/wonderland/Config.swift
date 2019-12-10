//
//  File.swift
//  wonderland
//
//  Created by Forwhfang on 2019/11/12.
//  Copyright © 2019 SCUT_wonderland. All rights reserved.
//

import Foundation
import UIKit

let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!

let userInfoURL = DocumentsDirectory.appendingPathComponent("userInfo")

var currUsername = ""

func loadArticleMetaURL() -> URL {
    return DocumentsDirectory.appendingPathComponent(currUsername).appendingPathComponent("articleMeta")
}

func loadArticleURL() -> URL {
    return DocumentsDirectory.appendingPathComponent(currUsername).appendingPathComponent("article")
}
