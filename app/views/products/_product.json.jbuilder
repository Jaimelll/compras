json.extract! product, :id, :nombre, :descripcion, :orden, :obs, :AdminUser_id, :created_at, :updated_at
json.url product_url(product, format: :json)
