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
      # a = KEYS[input[0].to_s] || []
      # (1..input.length - 1).each do |i|
      #   b = KEYS[input[i].to_s]
      #   a = a.product(b).map { |s| s.flatten.join('') }
      # end
      # comb_array = a.uniq
      # comb_array.each_slice(100).each do |i|
      #   query = "SELECT * FROM contact_lists WHERE LOWER(name) like any (array ['%#{i.join("%','%")}%'] ) LIMIT 10"
      #   active_record_result = ActiveRecord::Base.connection.execute(query)
      # end  
      # active_record_result.to_json
      a=''
      for i in 0..input.length-1 do
        a=a+"(#{KEYS[input[i].to_s].join('|')})"
      end
      puts "===============>>A=============#{a}"
      query = "SELECT * FROM contact_lists WHERE LOWER(name) SIMILAR TO '%#{a}%' OR number like '%#{input}%'  LIMIT 10"         
      active_record_result = ActiveRecord::Base.connection.execute(query)
      active_record_result.to_json  
    end
  end
end
