import Foundation

/**
 Функция возвращает массив с датами из исходного массива в отсортированном виде,
 показывая ближайшие даты относительно текущего времени, не считая год.
 Как пример, функция будет полезна для отображения ближайших дней рождений, праздников или важных событий.
 
 - Parameters:
    - dateArray: Исходный массив с датами.
    - daysBefore: Количество дней перед текущим днем. Используется для корректировки текущей даты, когда надо, например, показывать прошедшие праздники и/или дни рождения. По умолчанию равно 0.
 */
func sortingArray(dateArray: [Date], daysBefore: Int = 0) -> [Date] {
    var nowMonth = Calendar.current.component(.month, from: Date())
    let nowDay = Calendar.current.component(.day, from: Date()) - daysBefore
    if nowDay < 0 { nowMonth = nowMonth == 1 ? 12 : nowMonth - 1 }
    let sortedDateArray = dateArray.sorted {
        let month1 = Calendar.current.component(.month, from: $0)
        let month2 = Calendar.current.component(.month, from: $1)
        if month1 == month2 {
            let day1 = Calendar.current.component(.day, from: $0)
            let day2 = Calendar.current.component(.day, from: $1)
            return day1 < day2
        } else {
            return month1 < month2
        }
    }
    let firstArray = sortedDateArray.filter {
        let month = Calendar.current.component(.month, from: $0)
        if month == nowMonth {
            let day = Calendar.current.component(.day, from: $0)
            return nowDay <= day
        } else {
            return nowMonth < month
        }
    }
    let secondArray = sortedDateArray.filter {
        let month = Calendar.current.component(.month, from: $0)
        if month == nowMonth {
            let day = Calendar.current.component(.day, from: $0)
            return nowDay > day
        } else {
            return nowMonth > month
        }
    }
    let sortedArray = firstArray + secondArray
    return sortedArray
}

// Пример использования функции
var dateArray: [Date] = []
for i in 1...30 {
    dateArray.append(Date(timeIntervalSince1970: 60 * 60 * 24 * 30 * Double(i)))
}
let newArray = sortingArray(dateArray: dateArray, daysBefore: 10)
