class Pet < ApplicationRecord
    validates :name, presence: true 
    SPECIES = %w(dog cat rabbit snake turtle)

    validates :species, inclusion: {in: SPECIES}
end
