class OmniProvider < ActiveRecord::Base
  belongs_to :<%= user_singular_name %>
  validates :<%= user_singular_name%>_id, :uid, :provider, :presence => true
  validates_uniqueness_of :uid, :scope => [:provider, :<%= user_singular_name %>_id]
end
