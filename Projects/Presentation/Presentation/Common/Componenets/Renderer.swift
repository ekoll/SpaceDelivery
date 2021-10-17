//
//  Renderer.swift
//  Presentation
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

public protocol Renderer: AnyObject {
    func updateUI()
    func present(error: String)
    func present(alert: String)
    func ask(yesNoQuestion: String, completion: @escaping (Bool) -> Void)
}
