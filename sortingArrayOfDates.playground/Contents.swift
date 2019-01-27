import Foundation

/**
 Функция возвращает массив с датами из исходного массива в отсортированном виде,
 показывая ближайшие даты относительно текущего времени, не считая год.
 Как пример, функция будет полезна для отображения ближайших дней рождений, праздников или важных событий.
 
 - Parameters:
    - dateArray: Массив с датами.
    - daysBefore: Количество дней перед текущим днем. Используется для корректировки текущей даты, когда надо, например, показывать прошедшие праздники и/или дни рождения. По умолчанию 0.
 */
func sortingArray(dateArray: [Date], daysBefore: Int = 0) -> [Date] {
    let calendar = Calendar.current
    let timeInterval = TimeInterval(60 * 60 * 24 * -daysBefore)
    let now = Date(timeIntervalSinceNow: timeInterval)
    let nowDay = calendar.component(.day, from: now)
    let nowMonth = calendar.component(.month, from: now)

    let sortedDateArray = dateArray.sorted {
        let month1 = calendar.component(.month, from: $0)
        let month2 = calendar.component(.month, from: $1)
        if month1 == month2 {
            let day1 = calendar.component(.day, from: $0)
            let day2 = calendar.component(.day, from: $1)
            return day1 < day2
        } else {
            return month1 < month2
        }
    }
    
    let arrayBeforeCurrentDate = sortedDateArray.filter {
        let month = calendar.component(.month, from: $0)
        if month == nowMonth {
            let day = calendar.component(.day, from: $0)
            return nowDay <= day
        } else {
            return nowMonth < month
        }
    }
    
    let arrayAfterCurrentDate = sortedDateArray.filter {
        let month = calendar.component(.month, from: $0)
        if month == nowMonth {
            let day = calendar.component(.day, from: $0)
            return nowDay > day
        } else {
            return nowMonth > month
        }
    }
    
    return arrayBeforeCurrentDate + arrayAfterCurrentDate
}

// Пример использования функции
var dateArray = [Date]()
let calendar = Calendar.current
for _ in 1...20 {
    let year = Int.random(in: 2015...2020)
    let month = Int.random(in: 1...12)
    let day = Int.random(in: 2...28)
    let dateComponents = DateComponents(calendar: calendar, year: year, month:  month, day: day)
    let composedDate = calendar.date(from: dateComponents)
    if let date = composedDate {
        dateArray.append(date)
    }
}
let newArray = sortingArray(dateArray: dateArray, daysBefore: 45)

print("Исходный массив:")
for date in dateArray { print(date) }

print("Новый массив:")
for date in newArray { print(date) }
