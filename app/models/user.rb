class User < ApplicationRecord
    has_secure_password
    
    EMAIL_REGEX = /\A[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}\z/
    validates :email, presence: true,
                      uniqueness: {case_sensitive: false},
                      format: {with: EMAIL_REGEX}
    has_many :trips, dependent: :destroy

    def has_trip?
        unless current_trip_id.nil?
            current_trip_id
        end
    end

end
