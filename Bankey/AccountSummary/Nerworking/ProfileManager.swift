//
//  ProfileManager.swift
//  Bankey
//
//  Created by Edwin Cardenas on 7/12/25.
//

import Foundation

protocol ProfileManageable: AnyObject {
    func fetchProfile(
        forUserId userId: String,
        completion: @escaping (Result<Profile, NetworkError>) -> Void
    )
}

enum NetworkError: Error {
    case serverError
    case decodingError
}

struct Profile: Codable {
    let id: String
    let firstName: String
    let lastName: String
}

class ProfileManager: ProfileManageable {

    func fetchProfile(
        forUserId userId: String,
        completion: @escaping (Result<Profile, NetworkError>) -> Void
    ) {
        guard
            let url = URL(
                string:
                    "https://python-bankey-flask-520607767384.us-east4.run.app/profile/\(userId)"
            )
        else {
            fatalError("AccountSummaryViewController profile url error.")
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {

                OperationQueue.main.addOperation {
                    completion(.failure(.serverError))
                }

                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                let profile = try decoder.decode(Profile.self, from: data)

                OperationQueue.main.addOperation {
                    completion(.success(profile))
                }
            } catch {
                print(error)

                OperationQueue.main.addOperation {
                    completion(.failure(.decodingError))
                }
            }

        }.resume()
    }

}
