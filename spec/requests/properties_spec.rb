require "rails_helper"

describe "Properties", type: :request do
  it "index path respond with http success status code" do
    get "/properties"
    expect(response.status).to eq(200)
  end

  it "index path returns a json with all properties" do
    user1 = User.create(email: "flavio@mail.com", phone: "123456789", name: "Flavio", password: "123456", role: 0)
    Property.create(address: "Avenida la Marina 1602", price: 3000, property_type: 0, operation_type: 1,
                    bedrooms: 4, bathrooms: 1, area: 100, about: "Property 1", active: true, user: user1)
    get "/properties"
    properties = JSON.parse(response.body)
    expect(properties.size).to eq 1
  end
end

describe "show path" do
  it "respond with http success status code" do
    user1 = User.create(email: "flavio@mail.com", phone: "123456789", name: "Flavio", password: "123456", role: 0)
    property = Property.create(address: "Avenida la Marina 1602", price: 3000, property_type: 0, operation_type: 1,
                               bedrooms: 4, bathrooms: 1, area: 100, about: "Property 1", active: true, user: user1)
    get property_path(property)
    expect(response).to have_http_status(:ok)
  end
  it "respond with the correct property" do
    user1 = User.create(email: "flavio@mail.com", phone: "123456789", name: "Flavio", password: "123456", role: 0)
    property = Property.create(address: "Avenida la Marina 1602", price: 3000, property_type: 0, operation_type: 1,
                               bedrooms: 4, bathrooms: 1, area: 100, about: "Property 1", active: true, user: user1)
    get property_path(property)
    actual_property = JSON.parse(response.body)
    expect(actual_property["id"]).to eql(property.id)
  end
  it "returns http status not found" do
    get "/properties/:id", params: { id: "xxx" }
    expect(response).to have_http_status(:not_found)
  end
end

describe "create path" do
  it "respond with http success status code" do
    user1 = User.create(email: "flavio@mail.com", phone: "123456789", name: "Flavio", password: "123456", role: 0)

    post properties_path, params: { property: { address: "Avenida la Marina 1602", price: 3000, property_type: "apartment",
                                                operation_type: "sale", bedrooms: 4, bathrooms: 1, area: 100, about: "Property 1", active: true,
                                                user: user1 } }, headers: { "Authorization" => "Token token=#{user1.token}" }
    expect(response).to have_http_status(:created)
  end

  it "respond with the correct data" do
    user1 = User.create(email: "flavio@mail.com", phone: "123456789", name: "Flavio", password: "123456", role: 0)
    post properties_path, params: { property: { address: "Avenida la Marina 1602", price: 3000, property_type: "apartment",
                                                operation_type: "sale", bedrooms: 4, bathrooms: 1, area: 100, about: "Property 1", active: true,
                                                user: user1 } }, headers: { "Authorization" => "Token token=#{user1.token}" }
    actual_property = JSON.parse(response.body)
    expect(actual_property["address"]).to eql("Avenida la Marina 1602")
    expect(actual_property["price"]).to eql(3000)
  end
end

describe "update path" do
  it "respond with http success status code" do
    user1 = User.create(email: "flavio@mail.com", phone: "123456789", name: "Flavio", password: "123456", role: 0)
    property = Property.create(address: "Avenida la Marina 1602", price: 3000, property_type: 0, operation_type: 1,
                               bedrooms: 4, bathrooms: 1, area: 100, about: "Property 1", active: true, user: user1)
    patch property_path(property.id), params: { property: { address: "Avenida Brasil" } },
                                      headers: { "Authorization" => "Token token=#{user1.token}" }
    expect(response).to have_http_status(:ok)
  end
end

describe "delete path" do
  it "respond with nil for property deleted" do
    user1 = User.create(email: "flavio@mail.com", phone: "123456789", name: "Flavio", password: "123456", role: 0)
    property = Property.create(address: "Avenida la Marina 1602", price: 3000, property_type: 0, operation_type: 1,
                               bedrooms: 4, bathrooms: 1, area: 100, about: "Property 1", active: true, user: user1)
    delete property_path(property.id), headers: { "Authorization" => "Token token=#{user1.token}" }
    expect(Property.find_by(id: property.id)).to be_nil
  end
end
