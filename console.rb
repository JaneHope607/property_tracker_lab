require('pry-byebug')
require_relative('models/property')

Property.delete_all()

property1 = Property.new( {'address' => '15 Braid Hills Road', 'value' => 400000, 'year_built' => 2000, 'build' => 'semi-detached'} )
property1.save()

property1.value = 420000
property1.update()

binding.pry
nil
