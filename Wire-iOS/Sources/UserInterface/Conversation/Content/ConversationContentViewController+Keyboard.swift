//
// Wire
// Copyright (C) 2018 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

import Foundation

extension ConversationContentViewController {
    @objc func setupSwipeToShowKeyboard() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeGesture.direction = .up
//        tableView.addGestureRecognizer(swipeGesture)
        view.addGestureRecognizer(swipeGesture)
    }

    @objc func handleSwipeGesture(_ sender: UISwipeGestureRecognizer?) {
        //Gesture detect - swipe up/down , can be recognized direction
        if sender?.direction == .up {
//            self.
            print("Up")
        }
//        else if sender?.direction == .down {
//            tf.resignFirstResponder()
//            print("down")
//        }
    }

}

extension ConversationViewController {
    @objc func printDebugInfo() {
        guard let tableView = contentViewController.tableView else { return }
        print("😒 tableView.frame \(tableView.frame)") // (0.0, 0.0, 375.0, 491.0) (keyboard off) ->  (0.0, 0.0, 375.0, 233.0) (keyboard on)

        // (0.0, -16.0) when scroll to top
        print("🖐️ tableView.contentOffset \(tableView.contentOffset)")// (0.0, 164.5) -> (0.0, 409.5)
//        print("🎊 tableView.contentInset \(tableView.contentInset)") /// TODO: remember the last offset before keyboard moving

//        tableView.contentOffset = CGPoint(x: 0, y: 174) ///TODO: keep it
    }
}
