class User < ApplicationRecord
    has_secure_password
    
    EMAIL_REGEX = /\A[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}\z/
    validates :email, presence: true,
                      uniqueness: {case_sensitive: false},
                      format: {with: EMAIL_REGEX}
    has_many :trips
end
