class ContactList < ApplicationRecord
  # Constants
  KEYS = {
    '0' => %w[0],
    '1' => %w[1],
    '2' => %w[a b c 2],
    '3' => %w[d e f 3],
    '4' => %w[g h i 4],
    '5' => %w[j k l 5],
    '6' => %w[m n o 6],
    '7' => %w[p q r s 7],
    '8' => %w[t u v 8],
    '9' => %w[w x y z 9]
  }.freeze
  # Validations
  validates :name, :number, presence: true
  validates :number, uniqueness: true
  validates :number, length: { is: 10 }

  # Callbacks

  # Methods
  def self.search_contact_list(input)
    if input.present?
      comb_str=''
      for i in 0..input.length-1 do
        comb_str=comb_str+"(#{KEYS[input[i].to_s].join('|')})"
      end
      query = "SELECT * FROM contact_lists WHERE LOWER(name) SIMILAR TO '%#{comb_str}%' OR number like '%#{input}%'  LIMIT 30"
      active_record_result = ActiveRecord::Base.connection.execute(query)
      active_record_result.to_json  
    end
  end
end
