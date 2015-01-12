class CharitableDonation < ActiveRecord::Base
  belongs_to :will

    validates :amount, presence: true, :format => { :with => /\A\d+(?:\.\d\d)?\z/ }, :numericality => {:greater_than => 0 }

    validates :name, presence: true, length: { maximum: 200 }, unless: "popular_charity"

    validates :instruction, length: { maximum: 2000 }, allow_blank: true

  def full_name
    self.first_name.titleize {+ " " + self.middle_name.titleize if middle_name} + " " + self.surname.titleize
  end

  def full_address
    self.address_one.titleize {+ ", " + self.address_two.titleize if address_two} + ", " + self.city.titleize + ", " + self.county.titleize + ", " + self.postcode.upcase + ", " + self.country.titleize
  end

end
