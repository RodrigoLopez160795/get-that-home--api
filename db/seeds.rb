user1=User.create(email: "flavio@mail.com", phone: "123456789", name: "Flavio", password: "123456", role: 0)
user2=User.create(email: "rodrigo@mail.com", phone: "987654321", name: "Rodrigo", password: "123456", role: 1)
#puts user1
property1=user1.properties.create(address: "Avenida la Marina 1602", price: 3000, property_type: 0, operation_type: 1, bedrooms: 4, bathrooms: 1, area: 100, about: "Property 1", active: true)
property2=user1.properties.create(address: "Avenida Arequipa 3184", price: 4000, property_type: 1, operation_type: 1, bedrooms: 3, bathrooms: 1, area: 150, about: "Property 2", active: true)
property3=user1.properties.create(address: "Avenida Garcilazo de la Vega 1348", price: 3500, maintenance: 120, property_type: 0, operation_type: 0, bedrooms: 2, bathrooms: 2, area: 85, pets: true, about: "Property 3", active: true)
photolist=[{io: File.open('db/images/diego.png'), filename: 'diego'},{io: File.open('db/images/diego.png'), filename: 'image1.jpg'}]
property1.photos.attach(photolist)
# property1.photos.attach(io: File.open('db/images/diego.png'), filename: 'diego')
# property1.photos.attach(io: File.open('db/images/diego.png'), filename: 'image1')