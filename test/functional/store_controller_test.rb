require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  setup do
    Fabricate(:product, :title => "My Book Title", :description => "yyy", :image_url => "zzz.jpg")
    Fabricate(:product, :title => "CoffeeScript Book", :description => "yyy", :image_url => "zzz.jpg")
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#columns #side a', minimum: 4
    assert_select '#main .entry', minimum: 2
    assert_select 'h3', 'CoffeeScript Book'
    assert_select '.price', /\$[,\d]+\.\d\d/
  end
end
