json.array! @comics do |comic|
  json.id comic.id
  json.text comic.text
  json.title comic.title
  json.image comic.image
  json.user_id comic.user_id
  json.nickname comic.user.nickname
  json.user_sign_in current_user

  
  json.array! @tags do |tag|
    json.name tag.name
    json.tag_id tag.id
  end


  
end





