require "date"
require 'yaml'

PATTERN = /(?<gender>[1-2])\s(?<birth_year>\d{2})\s(?<birth_month>\d{2})\s(?<district>\d{2})\s(\d{3} \d{3})\s(?<control_number>\d{2})/

def french_ssn_info(ssn_number)
  if ssn_number.match?(PATTERN) && control_number_correct?(ssn_number)
    match_data = ssn_number.match(PATTERN)
    gender = match_data[:gender].to_i
    birth_year = match_data[:birth_year].to_i
    birth_month = match_data[:birth_month].to_i
    district = match_data[:district]
    control_number = match_data[:control_number]

    "a #{gender_attribution(gender)}, born in #{Date::MONTHNAMES[birth_month]}, 19#{birth_year} in #{district_attribution(district)}"
  else
    return "The number is invalid"
  end
end

def control_number_correct?(ssn_number)
  cleared_ssn = ssn_number.gsub(" ", "")[0..-3].to_i
  control_number = ssn_number[-2..-1].to_i
  (97 - cleared_ssn) % 97 == control_number
end

def gender_attribution(gender_id)
  gender_id == 1 ? "man" : "woman"
end

def district_attribution(code)
  YAML.load_file('data/french_departments.yml')[code]
end

# Pseudo code
# 1. Find a pattern matchgingt a valid SSN
# 2. Check if control number is correct
  # if incorrect, return an error
  # else
    # 3. extract data from match
# 4.return a full info string

