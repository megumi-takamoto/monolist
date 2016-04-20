#「アイテム追加画面」ではAPIの結果を用いて商品一覧を表示
class ItemsController < ApplicationController
  before_action :logged_in_user , except: [:show]
  before_action :set_item, only: [:show]

  def new
    if params[:q]
      response = Amazon::Ecs.item_search(params[:q] , 
                                  :search_index => 'All' , 
                                  :response_group => 'Medium' , 
                                  :country => 'jp')
      @amazon_items = response.items #検索ワード(name=q)を指定した時はAPIを用いて、@amazon_itemsという変数に商品検索結果を渡してる
    end
  end

  def show
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end
end
