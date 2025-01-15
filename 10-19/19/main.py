def is_leap_year(year):
    return (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0)

def count_sundays():
    days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    day_of_week = 1 
    sundays_on_first = 0

    for year in range(1900, 1901):
        for month in range(12):
            day_of_week = (day_of_week + days_in_months[month] + (1 if month == 1 and is_leap_year(year) else 0)) % 7

    for year in range(1901, 2001):
        for month in range(12):
            if day_of_week == 0:
                sundays_on_first += 1
            day_of_week = (day_of_week + days_in_months[month] + (1 if month == 1 and is_leap_year(year) else 0)) % 7

    return sundays_on_first

print("Number of Sundays:", count_sundays())
