//
//  AccountSummaryViewController+Networking.swift
//  Bankey
//
//  Created by Edwin Cardenas on 7/6/25.
//

import UIKit

enum NetworkError: Error {
    case serverError
    case decodingError
}

struct Profile: Codable {
    let id: String
    let firstName: String
    let lastName: String
}

extension AccountSummaryViewController {

    func fetchProfile(
        forUserId userId: String,
        completion: @escaping (Result<Profile, NetworkError>) -> Void
    ) {
        guard
            let url = URL(
                string:
                    "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)"
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

struct Account: Codable {
    let id: String
    let type: AccountType
    let name: String
    let amount: Decimal
    let createdDateTime: Date
}

extension AccountSummaryViewController {

    func fetchAccounts(
        forUserId userId: String,
        completion: @escaping (Result<[Account], NetworkError>) -> Void
    ) {
        guard
            let url = URL(
                string:
                    "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)/accounts"
            )
        else {
            fatalError("AccountSummaryViewController account url error.")
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
                decoder.dateDecodingStrategy = .iso8601

                let accounts = try decoder.decode([Account].self, from: data)

                OperationQueue.main.addOperation {
                    completion(.success(accounts))
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
