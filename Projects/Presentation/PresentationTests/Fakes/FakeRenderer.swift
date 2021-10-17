//
//  FakeRenderer.swift
//  Presentation
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Presentation

class FakeRenderer: Renderer {
    var error: (String) -> Void
    var alert: (String) -> Void
    var yeNoQestion: (String) -> Bool
    var updateUi: () -> Void
    
    init(error: @escaping (String) -> Void = { _ in }, alert: @escaping (String) -> Void = { _ in }, yeNoQestion: @escaping (String) -> Bool = { _ in false }, updateUi: @escaping () -> Void = { }) {
        self.error = error
        self.alert = alert
        self.yeNoQestion = yeNoQestion
        self.updateUi = updateUi
    }
    
    func present(error: String) {
        self.error(error)
    }
    
    func present(alert: String) {
        self.alert(alert)
    }
    
    func ask(yesNoQuestion: String, completion: @escaping (Bool) -> Void) {
        completion(self.yeNoQestion(yesNoQuestion))
    }
    
    func updateUI() {
        updateUi()
    }
}
