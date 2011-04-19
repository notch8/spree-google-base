# See http://base.google.com/support/bin/answer.py?hl=en&answer=78170 for all other fields
GOOGLE_BASE_ATTR_MAP = [
  ['id', 'id'],
  ['mpn', 'sku'],
  ['title', 'name'],
  ['link', 'google_base_link'],
  ['description', 'google_base_description'],
  ['price', 'price'],
  ['condition', 'google_base_condition'],   
  ['brand', 'google_base_brand'],
  ['image_link', 'google_base_image_link'],
  ['product_type', 'google_base_product_type']
]


GOOGLE_BASE_FILTERED_ATTRS = ["brand", "condition", "id", "image_link", "mpn", "price", "product_type", "quantity"]
