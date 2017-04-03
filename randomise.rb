class << self
  def update_tier(name, &block)
    @params = {}
    instance_eval &block

    count = Item.where(parent_id: @params[:selector]).count
    if @params[:selector].nil?
      parent_id = nil
    else
      parent_id = Item.where(id: @params[:selector]).sample.id
    end

    new_name = @params[:name_method].call
    if count < @params[:low_watermark]
      Item.create(:name => new_name, :parent_id => parent_id)
    elsif count > @params[:high_watermark]
      Item.where(parent_id: @params[:selector]).sample.destroy
    else
      if rand(100) > @params[:create_percent]
        if rand(2) == 1
          Item.where(parent_id: @params[:selector]).sample.destroy
        else
          Item.create(:name => new_name, :parent_id => parent_id)
        end
      end
    end
  end

  def method_missing(method_sym, *arguments, &block)
    @params[method_sym] = arguments.first
  end
end

loop do
  update_tier :countries do
    low_watermark 3
    high_watermark 7
    create_percent 98
    selector nil
    name_method Faker::Address.method(:country)
  end

  country_ids = Item.where(:parent_id => nil).map(&:id)
  city_ids = Item.where(parent_id: country_ids).map(&:id)

  update_tier :cities do
    low_watermark 5
    high_watermark 20
    create_percent 80
    selector country_ids
    name_method Faker::Address.method(:city)
  end

  city_ids = Item.where(parent_id: country_ids).map(&:id)

  update_tier :streets do
    low_watermark 25
    high_watermark 250
    create_percent 50
    selector city_ids
    name_method Faker::Address.method(:street_name)
  end

  30.times do
    item = Item.all.sample
    Person.create(:name => Faker::Name.name, :job => Faker::Job.title, :beer => Faker::Beer.name, :item_id => item.id)
    if Person.all.count > 500
      Person.all.sample.destroy
    end
  end

  sleep 1
end
