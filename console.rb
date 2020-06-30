require('pry-byebug')
require_relative('models/property')

Property.delete_all()

property1 = Property.new( {'address' => '15 Braid Hills Road', 'value' => 400000, 'year_built' => 2000, 'build' => 'semi-detached'} )
property1.save()

property2 = Property.new( { 'address' => '10 Belmont Crescent', 'value' => 250000, 'year_built' => 1895, 'build' => 'terrace'})
property2.save()

property1.value = 420000
property1.update()

p Property.find_by_address('25 Belmont Crescent')

binding.pry
nil
