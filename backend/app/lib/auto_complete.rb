require 'set'
class AutoComplete
  def self.find_names(name)
    @name = "%#{name}%".downcase
    @response = Person.where("name LIKE ?", @name).includes(:institution)
    @institutions = Set.new
    return @response
  end

  def self.find_institutions(institution)
    @institution = "%#{institution}%".downcase
    @response = Institution.where("name LIKE ?", @institution)
    return {'institutions' => @response}
  end
end
