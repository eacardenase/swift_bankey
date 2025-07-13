//
//  AccountSummaryViewController+Networking.swift
//  Bankey
//
//  Created by Edwin Cardenas on 7/6/25.
//

import UIKit

struct Account: Codable {
    let id: String
    let type: AccountType
    let name: String
    let amount: Decimal
    let createdDateTime: Date
    
    static func makeSkeleton() -> Self {
        return Account(id: "1", type: .Banking, name: "Account name", amount: 0.0, createdDateTime: .now)
    }
}

extension AccountSummaryViewController {

    func fetchAccounts(
        forUserId userId: String,
        completion: @escaping (Result<[Account], NetworkError>) -> Void
    ) {
        guard
            let url = URL(
                string:
                    "https://python-bankey-flask-520607767384.us-east4.run.app/profile/\(userId)/accounts"
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
