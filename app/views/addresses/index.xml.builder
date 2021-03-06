xml.instruct!
xml.addresses do
  @addresses.each do |address|
    xml.address do
      xml.id address.id
      xml.uuid address.uuid
      xml.nickname address.nickname
      xml.video address.video
      xml.address address.address
      xml.balance address.balance
      xml.created_at address.created_at
      xml.updated_at address.updated_at
      xml.url address_url(address, format: :xml)
    end
  end
end
