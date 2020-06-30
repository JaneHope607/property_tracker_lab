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

    def update()
        db = PG.connect( {dbname: 'estate_agents', host: 'localhost'} )
        sql = "UPDATE properties
        SET (address, value, year_built, build)
        =
        ($1, $2, $3, $4) WHERE id = $5"
        values = [@address, @value, @year_built, @build, @id]
        db.prepare('update', sql)
        db.exec_prepared('update', values)
        db.close()
    end

    def self.delete_all()
        db = PG.connect( {dbname: 'estate_agents', host: 'localhost'} )
        sql = "DELETE FROM properties"
        db.prepare("delete_all", sql)
        db.exec_prepared("delete_all")
        db.close()
    end

    def delete()
        db = PG.connect( {dbname: 'estate_agents', host: 'localhost'} )
        sql = "DELETE FROM properties WHERE id = $1"
        values = [@id]
        db.prepare('delete', sql)
        db.exec_prepared('delete', values)
        db.close()
    end

    def self.find(id)
        db = PG.connect( {dbname: 'estate_agents', host: 'localhost'} )
        sql = "SELECT * FROM properties WHERE id = $1"
        values = [id]
        db.prepare('find', sql)
        found_properties = db.exec_prepared('find', values)
        db.close()
        return found_properties.map { |property| Property.new(property) }
    end

    def self.find_by_address(address)
        db = PG.connect( {dbname: 'estate_agents', host: 'localhost'} )
        sql = "SELECT * FROM properties WHERE address = $1"
        values = [address]
        db.prepare('find_by_address', sql)
        found_properties = db.exec_prepared('find_by_address', values)
        db.close()
        if found_properties 
            return found_properties.map { |property| Property.new(property) }
        else
            return nil
        end
    end

end
