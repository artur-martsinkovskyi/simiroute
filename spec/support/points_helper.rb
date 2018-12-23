module PointsHelper
  module_function
  def point_attributes
    [{
      lat: '41',
      lng: '24',
      altitude: '1371',
      tracked_at: Time.parse('2008-08-15T07:03:56Z')
    },
    {
      lat: '42',
      lng: '25',
      altitude: '1372',
      tracked_at: Time.parse('2008-08-15T07:03:58Z')
    },
    {
      lat: '43',
      lng: '26',
      altitude: '1373',
      tracked_at: Time.parse('2008-08-15T07:03:59Z')
    }]
  end
end
