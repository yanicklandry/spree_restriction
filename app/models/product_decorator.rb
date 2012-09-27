Spree::Product.class_eval do
  attr_accessible :role_ids

  has_and_belongs_to_many :roles, :join_table => 'spree_restrictions'
    
  scope :by_roles, lambda{ |user_roles| 
    if(user_roles.include?(Spree::Role.find_by_name('admin')))
      where('1=1')
    else
      where('spree_products.id IN (
        SELECT p.id FROM spree_products p LEFT JOIN spree_restrictions r ON r.product_id = p.id WHERE r.product_id IS NULL
      )
      OR spree_products.id IN (
        SELECT p.id FROM spree_products p JOIN spree_restrictions r ON r.product_id = p.id WHERE role_id IN (?)
      )', user_roles.collect{|role|role.id}.join(','))
    end
  }
end