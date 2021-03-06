require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def new_product(image_url)
    Product.new(  title: "Test title",
                  description: "Test description",
                  price: 15.50,
                  image_url: image_url)
  end
  
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  
  test "product price must be positive" do
    product = Product.new(  title: "Titulo del libro",
                            description: "Descripcion del libro",
                            image_url: "imgane.png")
                           
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
                  product.errors[:price].join('; ')
                  
    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
                  product.errors[:price].join('; ')
                  
    product.price = 1
    assert product.valid?
  end
  
  test "image url" do
    ok = %w{ asd.gif asd.jpg asd.png ASD.JPG ASD.Jpg http://a.b.c./x/y/asd.png }
    bad = %w{ asd.doc asd.gif/qwe asd.gif.qwe }
    
    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end
    
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end
  
  test "product is not valid without a unique title" do
    product = Product.new(  title: products(:ruby).title,
                            description: "Description",
                            price: 9.99,
                            image_url: "asd.jpg")
    assert !product.save
    assert_equal "has already been taken", product.errors[:title].join('; ')
  end
  
  test "product title must have 10 characters at least" do
    product = Product.new(  title: "Short",
                            description: "A description",
                            image_url: "asd.jpg",
                            price: 15.50)
    assert product.invalid?, "#{product.title} is too short"
  end
  
  test "product URL must be unique" do
    product = Product.new(  title: "A Title! 2",
                            description: "Desc",
                            image_url: products(:ruby).image_url,
                            price: 12.50)
                                             
    assert product.invalid?, "URL must be unique"
  end
  
  test "product price must be equal or less than 1000" do
    product = Product.new(  title: "A Title! 2",
                            description: "Desc",
                            image_url: "url_one.png",
                            price: 1001)
    assert product.invalid?, "price must be equal or less than 1000"
  end
end
