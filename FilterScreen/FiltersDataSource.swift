//
//  FiltersDataSource.swift
//  FilterScreen
//
//  Created by Kushal Choudhary on 07/05/21.
//

import Foundation
protocol FilterDataSourceDelegates {
    func didSortingOptionChanged(sort: SortByOptions)
    func didFiltersChanged(newFilters: [CollectionFilter])
    func didFIlterExpanded(group: CollectionFilterGroups)
}
class FilterDataSource {
    var delegate:FilterDataSourceDelegates?
    
    private var selectedFilters: [CollectionFilter] = []
    private var selectedSortingOption:SortByOptions = .mostpopular
    let filters = [(CollectionFilterGroups.TYPE, CollectionFilter.typeFilters),
                   (CollectionFilterGroups.COOKINGMETHOD,CollectionFilter.cookingMethodFIlters),
                   (CollectionFilterGroups.CUT, CollectionFilter.CutFilters),
                   (CollectionFilterGroups.DIET, CollectionFilter.dietAndNutriFilters),
                   (CollectionFilterGroups.USDAGRADE, CollectionFilter.usdaGradeFilters)
    ]
    let sortingOptions = SortByOptions.options
    private var expandedFilters: [CollectionFilterGroups] = []
    func isExpanded(group: CollectionFilterGroups) -> Bool {
        return self.expandedFilters.contains { (oldgroup) -> Bool in
            return oldgroup == group
        }
    }
    func toggleExpandFilter(filter: CollectionFilterGroups){
        if expandedFilters.contains(where: { (oldFilter) -> Bool in
            return oldFilter == filter
        }){
            self.expandedFilters.removeAll { (oldFilter) -> Bool in
                return oldFilter == filter
            }
        }else{
            self.expandedFilters.append(filter)
        }
        self.delegate?.didFIlterExpanded(group: filter)
    }
    func didSelectFilter(filter: CollectionFilter){
        if selectedFilters.contains(where: { (oldFilter) -> Bool in
            return oldFilter == filter
        }){
            self.selectedFilters.removeAll { (oldFilter) -> Bool in
                return oldFilter == filter
            }
        }else{
            self.selectedFilters.append(filter)
        }
        self.delegate?.didFiltersChanged(newFilters: self.selectedFilters)
    }
    func isFilterSelected(filter: CollectionFilter) -> Bool {
        return selectedFilters.contains(where: { (oldFilter) -> Bool in
            return oldFilter == filter
        })
    }
    
    func isSortingSelected(sort: SortByOptions) -> Bool {
        return sort == self.selectedSortingOption
    }
    func selectSortingOption(sort: SortByOptions) {
        self.selectedSortingOption = sort
        self.delegate?.didSortingOptionChanged(sort: sort)
    }
    
}

enum CollectionFilterGroups: String {
    case TYPE
    case USDAGRADE = "USDA GRADE"
    case DIET
    case COOKINGMETHOD = "COOKING METHOD"
    case CUT
}
enum CollectionFilter : String{
    //    Diet and nutri
    case DIETANDNUTRITION = "DIET & NUTRITION"
    //    Cooking method
    case BAKE
    case SLOWCOOKER = "SLOW COOKER"
    case PANFRY
    case GRILL
    //    USDA GRade
    case USDACHOICE = "USDA CHOICE"
    //    Type
    case VEGETABLEANDFRUITS = "VEGETABLE & FRUITS"
    case FISHANDSEAFOOD = "FISH & SEAFOOD"
    case CHICKENANDPOULTRY = "CHICKEN & POULTRY"
    //    CUT
    case RIB
    case LOIN
    case CHUCK
    case SERLION
    case BREAST
    
    static let dietAndNutriFilters = [DIETANDNUTRITION]
    static let cookingMethodFIlters = [BAKE, SLOWCOOKER ,PANFRY, GRILL]
    static let usdaGradeFilters = [USDACHOICE]
    static let typeFilters = [VEGETABLEANDFRUITS,FISHANDSEAFOOD,CHICKENANDPOULTRY ]
    static let CutFilters = [RIB, LOIN, CHUCK, SERLION, BREAST]
    
}
enum SortByOptions : String{
    case mostpopular = "MOST POPULAR"
    case titleASC = "TITLE (A-Z)"
    case titleDSC = "TITLE (Z-A)"
    case PriceASC = "PRICE (LOW-HIGH)"
    case PriceDSC = "PRICE (HIGH-LOW)"
    static let options:[SortByOptions] = [.mostpopular,.titleASC, .titleDSC, .PriceASC, .PriceDSC]
}

