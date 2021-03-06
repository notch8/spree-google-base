module Spree
  Product.class_eval do
    scope :google_base_scope, -> { where(show_price: true).active.includes(:taxons) }

    def google_base_title
      name.truncate(70)
    end

    def google_base_description
      description
    end

    def google_base_condition
      'new'
    end

    def google_base_availability
      'in stock'
    end

    def google_base_image_link
      image = images.first and
      image_path = image.attachment.url(:product) and
      [Spree::GoogleBase::Config[:public_domain], image_path].join
    end

    def google_base_brand
      pp = Spree::ProductProperty.joins(:property).where('product_id' => self.id, 'spree_properties.name' => 'brand').first
      pp ? pp.value : nil
    end

    def google_base_product_category
      product_type = 'Electronics > Communications > Telephony'
      priority = -1000
      self.taxons.each do |taxon|
        if taxon.taxon_map && taxon.taxon_map.priority > priority
          priority = taxon.taxon_map.priority
          product_type = taxon.taxon_map.product_type
        end
      end
      product_type
    end

    def google_base_taxon_type
      product_type = if taxons.any?
         taxons[0].self_and_ancestors.map(&:name).join(" > ")
        else
         'Electronics > Communications > Telephony'
        end
    end

    def google_base_price
      price_in(current_currency).display_price
    end
  end
end
