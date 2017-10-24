//
//  Message.swift
//  Devchat
//
//  Created by yoann lathuiliere on 24/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import Foundation

class Message {
    private var _senderUID: String
    private var _text: String
    private var _mediaURL: String
    private var _openCount: Int
    private var _infos: String
    
    var senderUID: String {
        return _senderUID
    }
    
    var text: String {
        return _text
    }
    
    var mediaURL: String {
        return _mediaURL
    }
    
    var openCount: Int {
        return _openCount
    }
    
    var infos: String {
        return _infos
    }
    
    init(senderUID: String, text: String, mediaURL: String, openCount: Int, infos: String) {
        self._senderUID = senderUID
        self._text = text
        self._mediaURL = mediaURL
        self._openCount = openCount
        self._infos = infos
    }
}
