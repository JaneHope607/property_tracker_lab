require('pg')

class Property

    attr_accessor :address, :value, :year_built, :square_feet
    attr_reader :id

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @address = options['address']
        @value = options['value']
        @year_built = options['year_built']
        @square_feet = options['square_feet']
    end

end
