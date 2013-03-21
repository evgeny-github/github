class GoodsController < ApplicationController

  # def order3
  #   # @goods = Good.find([1,2,5])
  #   @goods = []
  #   items = []
  #   @debug = []
  #   params[:goods].each { | elem |
  #     good_id = elem[0]
  #     #~ @debug << elem[1][:quantity]
  #     unless elem[1][:ordered].nil?
  #       @debug << "item id is #{good_id}"
  #       @debug << elem[1][:ordered]
  #       @debug << elem[1][:quantity]
  #       @debug << current_user.class
  #       #~ basket = current_user.baskets.create({:good => Good.find(good_id)})
  #       #~ basket.save
        
  #     end

  #   }
  #   #~ @goods = Good.find([])
  #   #~ @debug << @goods.size
  #   #~ @goods = Good.find([items])
  #   #~ @debug << @goods[0].attributes['count']
  #   #~ @debug = items

  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @goods }
  #   end
  # end


  # def order2
  #   @goods = Good.all

  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @goods }
  #   end
  # end

  def order
    @goods = Good.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @goods }
    end
  end




  # GET /goods
  # GET /goods.json
  def index
    @title = 'goods list'
    @goods = Good.all
    if admin_signed_in?
      render 'index_admin'
    elsif user_signed_in?
      render 'index_user'
    else
      render 'index_guest'
    end
=begin
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @goods }
    end
=end
  end

  # GET /goods/1
  # GET /goods/1.json
  def show
    @good = Good.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @good }
    end
  end

  # GET /goods/new
  # GET /goods/new.json
  def new
    @good = Good.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @good }
    end
  end

  # GET /goods/1/edit
  def edit
    @good = Good.find(params[:id])
  end

  # POST /goods
  # POST /goods.json
  def create
    @good = Good.new(params[:good])

    respond_to do |format|
      if @good.save
        format.html { redirect_to @good, notice: 'Good was successfully created.' }
        format.json { render json: @good, status: :created, location: @good }
      else
        format.html { render action: "new" }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /goods/1
  # PUT /goods/1.json
  def update
    @good = Good.find(params[:id])

    respond_to do |format|
      if @good.update_attributes(params[:good])
        format.html { redirect_to @good, notice: 'Good was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goods/1
  # DELETE /goods/1.json
  def destroy
    @good = Good.find(params[:id])
    @good.destroy

    respond_to do |format|
      format.html { redirect_to goods_url }
      format.json { head :no_content }
    end
  end
end
