require "rails_helper"

describe "Users", type: :request do
  # it 'index path returns a json with all properties' do
  #     Property.create(address: "Avenida la Marina 1602", price: 3000, property_type: 0, operation_type: 1, bedrooms: 4, bathrooms: 1, area: 100, about: "Property 1", active: true, user:user1)
  #     get '/properties'
  #     properties = JSON.parse(response.body)
  #     expect(properties.size).to eq 1
  #   end
end

describe "create path" do
  it "respond with http success status code" do
    post users_path,
         params: { email: "flavio3@mail.com", phone: "123456789", name: "Flavio", password: "1234546",
                   role: "landlord" }
    expect(response).to have_http_status(:created)
  end

  it "respond with the correct data" do
    post users_path,
         params: { email: "flavio3@mail.com", phone: "123456789", name: "Flavio", password: "1234546",
                   role: "landlord" }
    actual_user = JSON.parse(response.body)
    expect(actual_user["email"]).to eql("flavio3@mail.com")
    expect(actual_user["phone"]).to eql("123456789")
    expect(actual_user["name"]).to eql("Flavio")
  end
end

describe "show path" do
  it "respond with http success status code" do
    user1 = User.create(email: "flavio@mail.com", phone: "123456789", name: "Flavio", password: "123456", role: 0)
    get profile_path, headers: { "Authorization" => "Token token=#{user1.token}" }
    expect(response).to have_http_status(:ok)
  end

  it "respond with the correct data" do
    user1 = User.create(email: "flavio@mail.com", phone: "123456789", name: "Flavio", password: "123456", role: 0)
    get profile_path, headers: { "Authorization" => "Token token=#{user1.token}" }
    actual_user = JSON.parse(response.body)
    expect(actual_user["email"]).to eql(user1.email)
    expect(actual_user["phone"]).to eql(user1.phone)
    expect(actual_user["name"]).to eql(user1.name)
  end
end

describe "update path" do
  it "respond with http success status code" do
    user1 = User.create(email: "flavio@mail.com", phone: "123456789", name: "Flavio", password: "123456", role: 0)
    patch profile_path, params: { phone: "987654321", name: "Fabian" },
                        headers: { "Authorization" => "Token token=#{user1.token}" }
    expect(response).to have_http_status(:ok)
  end

  it "respond with the correct data" do
    user1 = User.create(email: "flavio@mail.com", phone: "123456789", name: "Flavio", password: "123456", role: 0)
    patch profile_path, params: { phone: "987654321", name: "Fabian" },
                        headers: { "Authorization" => "Token token=#{user1.token}" }
    actual_user = JSON.parse(response.body)
    expect(actual_user["phone"]).to eql("987654321")
    expect(actual_user["name"]).to eql("Fabian")
  end
end
