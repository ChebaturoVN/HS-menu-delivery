//
//  CountryNameService.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 06.07.2023.
//

import Foundation

protocol CountryNameServiceProtocol {
    func getCityList(completion: @escaping ([String]?) -> Void)
}

final class CountryNameService: CountryNameServiceProtocol {

    func getCityList(completion: @escaping ([String]?) -> Void) {
        let restManager = RESTManager()
        let url = URL(string: "http://htmlweb.ru/json/geo/city_list?country=russia&api_key=8631f2e462083cff3228eb8cd9f204e9")!

        restManager.request(url: url, method: .get) { (response: APIResponse<CityesModel>) in
            if response.statusCode == 200, let data = response.data {
                let listCity = data.items.map { $0.name }
                completion(listCity)
            } else {
                print("Error occurred or invalid response")
            }
        }
    }
}
