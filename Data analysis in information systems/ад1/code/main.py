import csv
from datetime import datetime

def date_edit(row_name, source, dest, start_date_format, flag):
    with open(source, 'r') as csvfile:
        reader = csv.DictReader(csvfile)
        with open(dest, 'w', newline='') as outfile:
            fieldnames = reader.fieldnames
            writer = csv.DictWriter(outfile, fieldnames=fieldnames)
            writer.writeheader()
            for row in reader:
                date_str = row[row_name]
                date = datetime.strptime(date_str, start_date_format)
                updated_date_str = date.strftime('%Y-%m-%d')
                row[row_name] = updated_date_str
                if flag == 1:
                    old_value = row['match_id']
                    new_value = old_value[2:]
                    row['match_id'] = new_value
                writer.writerow(row)


if __name__ == "__main__":
    date_edit('date_of_birth', 'managers.csv', 'updated_managers.csv', '%m/%d/%Y', 0)
    date_edit('date_time', 'matches.csv', 'updated_matches.csv', '%d-%b-%y %I.%M.%S.%f000000 PM', 1)
