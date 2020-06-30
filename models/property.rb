require('pg')

class Property

    attr_accessor :address, :value, :year_built, :build
    attr_reader :id

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @address = options['address']
        @value = options['value'].to_i()
        @year_built = options['year_built'].to_i()
        @build = options['build']
    end

    def save()
        db = PG.connect( {dbname: 'estate_agents', host: 'localhost'} )
        sql = "INSERT INTO properties
        (address, value, year_built, build)
        VALUES ($1, $2, $3, $4)
        RETURNING id"
        values = [@address, @value, @year_built, @build]
        db.prepare("save", sql)
        @id = db.exec_prepared("save", values)[0]['id'].to_i()
        db.close()
    end



end
