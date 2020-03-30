//
//  FetchTokenContractCurrencyStat.swift
//  Proton
//
//  Created by Jacob Davis on 3/18/20.
//  Copyright © 2020 Needly, Inc. All rights reserved.
//

import Foundation
import EOSIO

class FetchTokenContractCurrencyStat: AbstractOperation {
    
    var tokenContract: TokenContract
    var chainProvider: ChainProvider

    init(tokenContract: TokenContract, chainProvider: ChainProvider) {
        self.tokenContract = tokenContract
        self.chainProvider = chainProvider
    }
    
    override func main() {
        
        guard let url = URL(string: self.chainProvider.chainUrl) else {
            self.finish(retval: nil, error: WebServiceError.error("ERROR: Missing url for get table rows"))
            return
        }

        let client = Client(address: url)
        let req = API.V1.Chain.GetTableRows<TokenContractCurrencyStatsABI>(code: tokenContract.contract,
                                                      table: Name(stringValue: "stat"),
                                                      scope: self.tokenContract.symbol.symbolCode)

        do {

            let res = try client.sendSync(req).get()

            if let currencyStat = res.rows.first {
                self.tokenContract.maxSupply = currencyStat.maxSupply
                self.tokenContract.supply = currencyStat.supply
            }

            self.finish(retval: self.tokenContract, error: nil)

        } catch {
            print("ERROR: \(error.localizedDescription)")
            self.finish(retval: nil, error: error)
        }
        
    }
    
}