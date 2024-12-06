class Trip < ApplicationRecord
  validates_presence_of    :code
  validates_uniqueness_of  :code
  belongs_to :user

end
