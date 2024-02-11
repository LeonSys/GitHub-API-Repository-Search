//
//  Constants.swift
//  GitRepos
//
//  Created by Leon Horvath on 10/02/2024.
//

enum SFSymbols {
    static let location = "mappin.and.ellipse" 
    static let user = "person.circle"
    static let star = "star.fill"
    static let fork = "tuningfork"
    static let lastUpdated = "clock.arrow.circlepath"
    static let created = "plus.square"
}

enum AlertMessages {
    static let emptySearchFieldTitle = "Empty searchfield"
    static let emptySearchFieldMessage = "Please enter a word in the search field"
    static let noResultsOnSearchTitle = "No results"
    static let noResultsOnSearchMessage = "There is no repository named "
    static let errorDuringFetchTitle = "Network Error"
    static let errorDuringFetchMessage = "An error occured during fetching the data"
    static let alertButtonTitle = "Ok"
}

enum NetworkError: String, Error {
    case badURL = "Something is worng with the URL, please check"
    case requestError = "Unable to complete your request"
    case invalidResponse = "Invalid response from server"
    case invalidDataRecieved = "Invalid data recieved from server"
}
