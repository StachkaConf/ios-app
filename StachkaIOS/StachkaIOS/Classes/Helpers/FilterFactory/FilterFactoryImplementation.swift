//
//  FilterFactoryImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 31.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class FilterFactoryImplementation: FilterFactory {

    private var categoryNames = ["Разработка", "Digital-маркетинг", "Бизнес", "Образование и карьера"]
    private var placeNames = ["БОЛЬШОЙ ЗАЛ", "КИНОБАР", "АРХИВ", "ПРЕСС-ЦЕНТР",
                              "ФОЙЕ ОПЦ", "КИНОЗАЛ МУЗЕЯ", "ОКТЯБРЬСКИЙ", "ЗАЛ МУЗЕЯ №16", "ФОЙЕ МУЗЕЯ", "СОВЕТСКАЯ ШКОЛА"]
    private var sectionNames = ["Разработка": ["Информационная безопасность", "Менеджмент", "HighLoad",
                                                         "Виртуальная реальность", "DevOps", "FrontEnd", "BackEnd",
                                                         "Мобильная", "Database", "Тестирование", "Управление требованиями",
                                                         "Машинное обучение"],
                                "Digital-маркетинг": ["Digital", "SEO", "Web-аналитика", "Графический продакшен", "Лидогенерация"],
                                "Бизнес": ["Бизнес-инструменты", "Электронная коммерция"],
                                "Образование и карьера": ["Подготовка ИТ профессионалов", "Студентам", "Управленцам, HR-ам", "IT-сообщества"]]


    func createFilters() -> [Filter] {
        return [createAllPlacesFilter()] + createCategoryFilters()
    }

    private func createCategoryFilters() -> [CategoryFilter] {
        return categoryNames.map {
            let categotyFilter = CategoryFilter()
            categotyFilter.title = $0
            let objects = createSectionFilter(withCategory: $0)

            // FIXME: почему-то синтаксис с append(objectsIn:) не заработал
            objects.forEach {
                categotyFilter.sectionFilters.append($0)
            }

            return categotyFilter
        }
    }

    private func createAllPlacesFilter() -> AllPlacesFilter {
        let allPlacesFilter = AllPlacesFilter()
        allPlacesFilter.title = "Залы"
        placeNames.forEach {
            let placeFilter = PlaceFilter()
            placeFilter.title = $0
            allPlacesFilter.placeFilters.append(placeFilter)
        }
        return allPlacesFilter
    }

    private func createSectionFilter(withCategory category: String) -> [SectionFilter] {
        return sectionNames[category]?.map {
            let sectionFilter = SectionFilter()
            sectionFilter.title = $0
            return sectionFilter
        } ?? []
    }
}
