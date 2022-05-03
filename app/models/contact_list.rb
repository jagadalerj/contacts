class ContactList < ApplicationRecord
  # Constants
  KEYS = {
    '0' => %w[],
    '1' => %w[],
    '2' => %w[a b c],
    '3' => %w[d e f],
    '4' => %w[g h i],
    '5' => %w[j k l],
    '6' => %w[m n o],
    '7' => %w[p q r s],
    '8' => %w[t u v],
    '9' => %w[w x y z]
  }.freeze
  # Validations
  validates :name, :number, presence: true
  validates :number, uniqueness: true
  validates :number, length: { is: 10 }

  # Callbacks

  # Methods
  def self.search_contact_list(input)
    if input.present?
      a = KEYS[input[0].to_s] || []
      (1..input.length - 1).each do |i|
        b = KEYS[input[i].to_s]
        a = a.product(b).map { |s| s.flatten.join('') }
      end
      a.uniq
      query = "SELECT * FROM contact_lists WHERE LOWER(name) like any (array ['%#{a.join("%','%")}%'] ) LIMIT 10"
      active_record_result = ActiveRecord::Base.connection.execute(query)
      active_record_result.to_json
    end
  end
end
