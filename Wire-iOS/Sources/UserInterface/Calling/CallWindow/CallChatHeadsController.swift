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

protocol ChatHeadPresenter {
    func show(chatHead: ChatHeadView)
}

final class CallChatHeadsController {

    private var participants = Set<UUID>()
    private let presenter: ChatHeadPresenter?
    private let voiceChannel: VoiceChannel
    
    init(presenter: ChatHeadPresenter?, voiceChannel: VoiceChannel) {
        self.presenter = presenter
        self.voiceChannel = voiceChannel
    }
    
    func updateParticipants(_ newParticipants: [(UUID, CallParticipantState)]) {
        updateParticipantsList(newParticipants.map { $0.0 })
    }
    
    // MARK: - Private
    
    private func updateParticipantsList(_ newParticipants: [UUID]) {
        let updated = Set(newParticipants)
        defer { participants = updated }
        guard updated.count > 1, voiceChannel.state == .established else { return }

        let added = updated.subtracting(participants).compactMap { uuid in
            voiceChannel.conversation?.activeParticipants
                .lazy
                .compactMap { $0 as? ZMUser }
                .first { $0.remoteIdentifier == uuid }
        }

        added.forEach { user in
            presenter?.show(chatHead: .init(
                title: nil,
                body: "call.chathead.joined".localized(args: user.displayName),
                userID: user.remoteIdentifier, sender: user
            ))
        }
        
        
    }
    
}
