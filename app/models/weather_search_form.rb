class WeatherSearchForm
    include ActiveModel::Validations
    include ActiveModel::Validations::Callbacks

    attr_accessor :address
    attr_accessor :zip_code
    attr_accessor :num_days

    validates_presence_of :address, :message => "Address Required"
    validates_presence_of :num_days, :message => "Number Of Days Required"

    after_validation :set_zip_code

    def set_zip_code
        return nil unless self.errors.empty?

        geocoder_result = Geocoder.search(self.address).first
        if geocoder_result.nil?
           self.zip_code = nil
           self.errors.add :address, "Invalid Address"
        else
            self.zip_code = geocoder_result.data["address"]["postcode"]
        end
    end
end