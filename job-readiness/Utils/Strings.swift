//
//  Strings.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 16/09/22.
//

import Foundation

enum ErrorStrings: String {
    case loginButtonText = "Fazer login"
    case authErrorText = "Sua sessão expirou!"
    case categoryErrorText = "Categoria inválida"
    case genericErrorText = "Ops, algo deu errado"
}

enum CellIdsStrings: String {
    case productTV = "productCell"
    case favProductCV = "favCell"
    case productImageCV = "imgCell"
}

enum InitialVCStrings: String {
    case homeVCTitle = "Home"
    case favProductsVCTitle = "Favoritos"
    case somethingVCTitle = "Mais"
}

enum UserDefaultsKeys: String {
    case favList = "FavList"
}

enum StoryboardsStrings: String {
    case main = "Main"
    case detailsSBID = "DetailsSB"
}
