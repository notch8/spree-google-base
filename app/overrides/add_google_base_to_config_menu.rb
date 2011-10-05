Deface::Override.new(:virtual_path => 'admin/configurations/index',
                     :name => 'add google base to config menu',
                     :insert_bottom => "[data-hook='admin_configurations_menu']",
                     :text => %q{<%= configurations_menu_item('Google Base', admin_google_base_settings_path, 'Google Base taxonomy management') %>}
                     :disabled => false)