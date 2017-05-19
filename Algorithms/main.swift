//
//  main.swift
//  Algorithms
//
//  Created by Richard Ash on 3/22/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import Foundation


let trie = Trie()

trie.insert("Hello")
trie.insert("Hi")
trie.insert("Worlds")

print(trie.contains("world"))
print(trie.contains("h"))
print(trie.contains("r"))
