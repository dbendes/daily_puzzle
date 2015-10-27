class AddPronounsToWikirace < ActiveRecord::Migration
  def change
    add_column :wikiraces, :first_article, :boolean, default: false
    add_column :wikiraces, :second_article, :boolean, default: false
  end
end
