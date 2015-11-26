class AddPostIdToTags < ActiveRecord::Migration
  def change
    add_belongs_to :tags, :post
  end
end
