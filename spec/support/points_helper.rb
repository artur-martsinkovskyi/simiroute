module PointsHelper
  module_function
  def point_attributes
    [{
      lat: '41',
      lon: '24',
      altitude: '1371',
      time: Time.parse('2008-08-15T07:03:56Z')
    },
    {
      lat: '42',
      lon: '25',
      altitude: '1372',
      time: Time.parse('2008-08-15T07:03:58Z')
    },
    {
      lat: '43',
      lon: '26',
      altitude: '1373',
      time: Time.parse('2008-08-15T07:03:59Z')
    }]
  end
end