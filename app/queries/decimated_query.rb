# frozen_string_literal: true

class DecimatedQuery
  attr_reader :records
  UNDECIMATABLE_LIMIT = 100
  DECIMATION_FACTOR = 3

  def initialize(records)
    @records = records
  end

  def call
    if size < UNDECIMATABLE_LIMIT
      records
    else
      records.find_by_sql(raw_sql_query)
    end
  end

  private

  def raw_sql_query
    %{
        SELECT * FROM
        (
          SELECT #{table_name}.*, row_number() OVER () AS rownum
          FROM #{table_name} ORDER BY id
        ) AS stats
        WHERE mod(rownum,#{DECIMATION_FACTOR}) = 0
    }
  end

  def table_name
    records.first.class.table_name
  end

  def size
    @size ||= records.count
  end
end
