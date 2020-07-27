class Gossip
  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find(id)
    CSV.read("./db/gossip.csv").each_with_index.map do |str, i|
      if i == id
        return str
      end
    end
  end

  def self.edit(id, author, content)
   temp_array = []
   CSV.foreach('./db/gossip.csv').with_index do |str, index|
     index == id.to_i ? str = [author, content] : nil
     temp_array << str
   end

   CSV.open('./db/temp.csv', 'w') do |csv|
     temp_array.each do |row_array|
       csv << row_array
     end
   end
   system('mv ./db/temp.csv ./db/gossip.csv')
  end
end
