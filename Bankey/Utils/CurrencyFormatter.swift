//
//  CurrencyFormatter.swift
//  Bankey
//
//  Created by Edwin Cardenas on 7/2/25.
//

import UIKit

struct CurrencyFormatter {

    func makeAttributedCurrency(_ amount: Decimal) -> NSAttributedString {
        let tuple = breakIntoDollarsAndCents(amount)

        return makeBalanceAttributed(dollars: tuple.dollars, cents: tuple.cents)
    }

    private func breakIntoDollarsAndCents(_ amount: Decimal) -> (
        dollars: String, cents: String
    ) {
        let tuple: (dollars: Double, cents: Double) = modf(amount.doubleValue)

        let dollars = convertDollar(tuple.dollars)
        let cents = convertCents(tuple.cents)

        return (dollars, cents)
    }

    private func convertDollar(_ dollarPart: Double) -> String {
        let dollarsWithDecimal = dollarsFormatted(dollarPart)
        let formatter = NumberFormatter()
        let decimalSeparator = formatter.decimalSeparator!
        let dollarComponents = dollarsWithDecimal.components(
            separatedBy: decimalSeparator
        )
        let dollars = dollarComponents.first!

        return dollars
    }

    private func convertCents(_ centPart: Double) -> String {
        let cents: String

        if centPart == 0 {
            cents = "00"
        } else {
            cents = String(format: "%.0f", centPart * 100)
        }

        return cents
    }

    private func dollarsFormatted(_ dollars: Double) -> String {
        let formatter = NumberFormatter()

        formatter.usesGroupingSeparator = true

        if let result = formatter.string(from: dollars as NSNumber) {
            return result
        }

        return ""
    }

    private func makeBalanceAttributed(dollars: String, cents: String)
        -> NSAttributedString
    {
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .callout),
            .baselineOffset: 8,
        ]
        let dollarAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .title1)
        ]
        let centsAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .footnote),
            .baselineOffset: 8,
        ]
        
        let currentLocale = Locale.current
        let currencySymbol = currentLocale.currencySymbol

        let rootString = NSMutableAttributedString(
            string: currencySymbol ?? "$",
            attributes: dollarSignAttributes
        )
        let dollarString = NSAttributedString(
            string: dollars,
            attributes: dollarAttributes
        )
        let centsString = NSAttributedString(
            string: cents,
            attributes: centsAttributes
        )

        rootString.append(dollarString)
        rootString.append(centsString)

        return rootString
    }

}
