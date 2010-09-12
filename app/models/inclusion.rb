class Inclusion < ActiveRecord::Base
  belongs_to :publication
  belongs_to :population

  def population_name
    population.name if population
  end

  def population_name=(name)
    self.population = Variable.find_or_create_by_name(name) unless name.blank?
  end
end
