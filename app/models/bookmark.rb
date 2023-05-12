require 'csv'
class Bookmark < ApplicationRecord
  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << column_names
      all.each do |bookmark|
        csv << bookmark.attributes.values_at(*column_names)
      end
    end
  end
end
