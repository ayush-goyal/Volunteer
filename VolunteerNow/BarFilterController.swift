//
//  BarFilterController.swift
//  VolunteerNow
//
//  Created by Macbook on 10/14/17.
//  Copyright © 2017 Ayush. All rights reserved.
//

import UIKit

enum SortTypes: String {
    case closest
    case upcoming
    case relevance
    case popularity
}

enum CategoryTypes: String {
    case all
    case children
    case seniors
    case animals
    case education
    case advocacy
}

class BarFilterController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var sortPicker: UIPickerView!
    
    let sortPickerDataSource: [SortTypes] = [.closest, .upcoming, .relevance, .popularity]
    let categoryPickerDataSource: [CategoryTypes] = [.all, .children, .seniors, .animals, .education, .advocacy]
    var selectedSort: SortTypes!
    var selectedCategory: CategoryTypes!

    override func viewDidLoad() {
        super.viewDidLoad()

        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        
        sortPicker.dataSource = self
        sortPicker.delegate = self
        
        categoryPicker.selectRow(categoryPickerDataSource.index(of: selectedCategory)!, inComponent: 0, animated: false)
        sortPicker.selectRow(sortPickerDataSource.index(of: selectedSort)!, inComponent: 0, animated: false)

    }
    
    //MARK: - Picker Functions
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == categoryPicker {
            return categoryPickerDataSource.count
        } else if pickerView == sortPicker {
            return sortPickerDataSource.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoryPicker {
            return categoryPickerDataSource[row].rawValue.capitalized
        } else if pickerView == sortPicker {
            return sortPickerDataSource[row].rawValue.capitalized
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoryPicker {
            selectedCategory = categoryPickerDataSource[row]
        } else if pickerView == sortPicker {
            selectedSort = sortPickerDataSource[row]
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveFilter" {
            if let viewController = segue.destination as? ContainerSearchController {
                viewController.selectedCategory = selectedCategory
                viewController.selectedSort = selectedSort
            }
        }
    }

}
