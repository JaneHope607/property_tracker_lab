require('pry-byebug')
require_relative('models/property')

property1 = Property.new( {'address' => '15 Braid Hills Road', 'value' => 400000, 'year_built' => 2000, 'build' => 'semi-detached'} )
property1.save()



binding.pry
nil
