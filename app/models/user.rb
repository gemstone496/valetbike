class User < ApplicationRecord
    has_secure_password
    mount_uploader :avatar, AvatarUploader

    EMAIL_REGEX = /\A[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}\z/
    PHONE_REGEX = /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}\z/
    validates :email, presence: true,
                      uniqueness: {case_sensitive: false},
                      format: {with: EMAIL_REGEX}
    
    validates :name, presence: false, 
                     length: {minimum: 1},
                     allow_nil: true,
                     allow_blank: true 
    
    validates :phone_number, presence: false, 
                             format: {with: PHONE_REGEX},
                             allow_nil: true,
                             allow_blank: true

    has_many :trips, dependent: :destroy

    def has_trip?
        unless current_trip_id.nil?
            current_trip_id
        end
    end

    after_create do
      customer = Stripe::Customer.create(email: email)
      update(stripe_customer_id: customer.id)
    end

    def has_name?
        unless name.nil?
            name
        end
    end
end
