class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  # def create
  #   @product = Product.create(product_params)
  #
  #   # respond_to do |format|
  #     if @product.save
  #       flash[:notice] = "Successfully created user."
  #       if params[:product][:photo].blank?
  #         redirect_to @product
  #       else
  #         render :crop
  #       end
  #       # format.html { redirect_to @product, notice: 'Product was successfully created.' }
  #       # format.json { render :show, status: :created, location: @product }
  #     else
  #       render :new
  #       # format.html { render :new }
  #       # format.json { render json: @product.errors, status: :unprocessable_entity }
  #     end
  #   # end
  # end
  #
  # # PATCH/PUT /products/1
  # # PATCH/PUT /products/1.json
  # def update
  #   if @product.update_attributes(product_params)
  #     flash[:notice] = "Successfully updated user."
  #     if params[:product][:photo].blank?
  #       redirect_to @product
  #     else
  #       render :action => 'crop'
  #     end
  #     # format.html { redirect_to @product, notice: 'Product was successfully created.' }
  #     # format.json { render :show, status: :created, location: @product }
  #   else
  #     render :action => 'edit'
  #     # format.html { render :new }
  #     # format.json { render json: @product.errors, status: :unprocessable_entity }
  #   end
  #   # respond_to do |format|
  #   #   if @product.update!(product_params)
  #   #     format.html { redirect_to @product, notice: 'Product was successfully updated.' }
  #   #     format.json { render :show, status: :ok, location: @product }
  #   #   else
  #   #     format.html { render :edit }
  #   #     format.json { render json: @product.errors, status: :unprocessable_entity }
  #   #   end
  #   # end
  # end


  def create
    @product = Product.new(product_params)
    if @product.save
      render "crop"
    else
      render :new
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        @product.reprocess_avatar
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :photo,:crop_x, :crop_y, :crop_w, :crop_h)
    end
end
