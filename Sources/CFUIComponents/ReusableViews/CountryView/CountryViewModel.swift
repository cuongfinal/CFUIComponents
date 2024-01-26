//
//  The MIT License (MIT)
//
//  Copyright (c) 2021 Cuong Le
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
// swiftlint:disable identifier_name
// swiftlint:disable line_length

import Foundation
import Combine

typealias Countries = [Country]

public struct Country: Codable, Identifiable {
    public var id: UUID = .init()
    
    // MARK: - Attributes
    let pattern, mask, cc, nameEn: String
    let dialCode, nameRu: String
    
    enum CodingKeys: String, CodingKey {
        case pattern, mask, cc
        case nameEn = "name_en"
        case dialCode = "dial_code"
        case nameRu = "name_ru"
    }
    
    var localizeName: String {
        if let languageCode = Locale.current.languageCode {
            return languageCode == "ru" ? self.nameRu : self.nameEn
        }
        return self.nameEn
    }
}

public class CountryViewModel: ObservableObject {
    // MARK: - Attributes
    @Published var countriesDictionary:[(key: String, value: [Country])] = []
    @Published var searchText: String = ""
    
    private var relatedCountries: Countries = []
    private var countries: Countries = []
    //    private let relatedList: [String]
    private var cancellableBag = Set<AnyCancellable>()
    
    // MARK: - Initializers
    init() {
        self.allCountries { result in
            switch result {
            case .success(let items):
                self.countries = items
            case .failure(let error): print(error)
            }
        }
        
        $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink(receiveValue: search(_:))
            .store(in: &cancellableBag)
    }
    
    public func localeCountry() -> Country? {
        if !relatedCountries.isEmpty {
            return relatedCountries.first
        }
        return countries.first { $0.cc == Locale.current.regionCode } ?? countries.first
    }
    
    public func country(value: String) -> Country? {
        var value = value
        if value.first == "+" { value.removeFirst() }
        
        for country in countries {
            let dialCodeCount = country.dialCode.count
            let valueDial = String(value.prefix(dialCodeCount))
            if valueDial == country.dialCode {
                return country
            }
        }
        return nil
    }
    
    public func setRelattedCountries(relatedList: [String]) {
        self.relatedCountries.removeAll()
        self.relatedCountries = Set(relatedList).compactMap { cc in countries.filter { $0.cc == cc }.first }
        self.prepareData()
    }
    
    private func prepareData() {
        self.countriesDictionary = Dictionary(grouping: countries, by: { String($0.localizeName.first ?? " " ) }).sorted { $0.0 < $1.0 }
        if relatedCountries.count > 0 {
            self.countriesDictionary.insert((key:"Related", value: relatedCountries), at: 0)
        }
    }
    
    // MARK: - Filter data by flag
    private func search(_ by: String) {
        guard !by.isEmpty else {
            prepareData()
            return
        }
        let filteredData = countries.filter { $0.localizeName.lowercased().contains(by.lowercased()) }
        self.countriesDictionary = [(key: filteredData.count > 0 ? "Result" : "Not found", value: filteredData)]
    }
    
    private func allCountries(completion:  @escaping (Result<Countries, Error>) -> Void) {
        if let path = Bundle.main.path(forResource: "CountryCodes", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl)
                let res = try JSONDecoder().decode(Countries.self, from: data)
                completion(.success(res))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
