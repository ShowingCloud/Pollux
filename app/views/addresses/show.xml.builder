xml.instruct!
xml.address do
  xml.id @address.id
  xml.uuid @address.uuid
  xml.video @address.video
  xml.address @address.address
  xml.balance @address.balance
  xml.created_at @address.created_at
  xml.updated_at @address.updated_at
  xml.url address_url(@address, format: :xml)
end
