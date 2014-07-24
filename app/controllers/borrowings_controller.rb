class BorrowingsController < ApplicationController
  before_action :set_borrowing, only: [:show, :edit, :update, :destroy, :number_supply, :submit_basket]

  # GET /borrowings
  # GET /borrowings.json
  def index
    @borrowings = Borrowing.all
  end

  # GET /borrowings/1
  # GET /borrowings/1.json
  def show
  end

  # GET /borrowings/new
  def new
    @borrowing = Borrowing.new
  end

  # GET /borrowings/1/edit
  def edit
  end

  # POST /borrowings
  # POST /borrowings.json
  def create
    @borrowing = Borrowing.new(borrowing_params)

    respond_to do |format|
      if @borrowing.save
        format.html { redirect_to @borrowing, notice: 'Borrowing was successfully created.' }
        format.json { render action: 'show', status: :created, location: @borrowing }
      else
        format.html { render action: 'new' }
        format.json { render json: @borrowing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /borrowings/1
  # PATCH/PUT /borrowings/1.json
  def update
    respond_to do |format|
      if @borrowing.update(borrowing_params)
        format.html { redirect_to @borrowing, notice: 'Borrowing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @borrowing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /borrowings/1
  # DELETE /borrowings/1.json
  def destroy
    @borrowing.destroy
    respond_to do |format|
      format.html { redirect_to borrowings_url }
      format.json { head :no_content }
    end
  end

  def number_supply
    if Supply.find(params[:supply]) && params[:number] 
      if params[:number] == "more" && @borrowing.loan!(Supply.find(params[:supply]))
        flash[:notice] = t("notice.supply.loan.success")
      elsif params[:number] == "less" && @borrowing.unloan!(Supply.find(params[:supply]))
        flash[:notice] = t("notice.supply.unloan.success")
      else
        flash[:error] = t("errors.supply.loan.failed")
      end
    else
      flash[:error] = t("errors.what_are_you_doing")
    end
    respond_to do |format|
      format.html { redirect_to @borrowing}
    end
  end

  def submit_basket
    if params[:borrowing][:start_at] && params[:borrowing][:end_at] && @borrowing.validate_basket!(params[:borrowing][:start_at], params[:borrowing][:end_at])
      flash[:success] = t("notice.borrowing.submit_basket")
    else
      flash[:error] = ""
      @borrowing.errors.messages.each_value{|v| flash[:error] += (v)}
      flash[:error] = t("errors.submit_basket.no_date") if flash[:error].blank?
    end
    respond_to do |format|
      format.html { redirect_to @borrowing}
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_borrowing
      @borrowing = Borrowing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def borrowing_params
      params.require(:borrowing).permit(:user_id, :end_at, :start_at, :ended_at, :effective)
    end
end
