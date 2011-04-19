Product.class_eval do
  scope :google_base_scope, where("show_price = true AND deleted_at IS NULL").includes(:taxons, :images)
  
  protected
  
  def google_base_description
    self.description.blank? ? self.meta_description : self.description
  end
  
  def google_base_condition  
    condition = 'new'  
    self.product_properties.each do |property|  
      condition = property.value if property.property.presentation == 'Condition'  
    end
    condition
  end

  def google_base_link
    public_dir = Spree::GoogleBase::Config[:public_domain] || ''
    [public_dir.sub(/\/$/, ''), 'products', self.permalink].join('/')
  end 
  
  
  def google_base_image_link
    public_dir = Spree::GoogleBase::Config[:public_domain] || ''
    if self.images.empty?
      nil
    else
      public_dir.sub(/\/$/, '') + self.images.first.attachment.url(:product)
    end
  end

  def google_base_product_type
    return nil unless Spree::GoogleBase::Config[:enable_taxon_mapping]
    product_type = ''
    priority = -1000
    self.taxons.each do |taxon|
      if taxon.taxon_map && taxon.taxon_map.priority > priority
        priority = taxon.taxon_map.priority
        product_type = taxon.taxon_map.product_type
      end
    end
    product_type
  end   
  
  def google_base_brand   
    brand = '' 
    self.product_properties.each do |property|  
      brand = property.value if property.property.presentation == 'Brand'  
    end
    brand
  end
    
end
