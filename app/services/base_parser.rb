class BaseParser
  def initialize(raw_data)
    @raw_data = raw_data
  end

  def people
    if raw_data.nil?
      return []
    end

    result = []

    rows.each do |row|
      result << Person.new(
        first_name: row['first_name'],
        last_name: row['last_name'],
        city: row['city'],
        birthdate: parse_date(row['birthdate']),
      )
    end

    result
  end
  
  private

  def rows
    CSV.parse(
      raw_data,
      col_sep: " #{separator} ",
      headers: true,
    )
  end

  def parse_date(date)
    return Date.strptime(date, '%m.%d.%Y') if /^\d{1,2}\.\d{1,2}\.\d{4}$/.match?(date)

    Date.parse(date)
  end

  attr_reader :raw_data
end
