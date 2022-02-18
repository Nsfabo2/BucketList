//
//  AddItemTableViewControllerDelegate.swift
//  BucketList
//
//
//

import Foundation
import UIKit
protocol AddItemTableViewControllerDelegate: class {
    func itemSaved(by controller: MissionDetailsTableViewController, with text: String, at indexPath: NSIndexPath?)
    func cancelButtonPressed(by controller: MissionDetailsTableViewController)

}

