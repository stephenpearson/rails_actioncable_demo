class PeopleController < ApplicationController
  before_action :set_person, only: [:edit, :update, :destroy]

  # GET /person
  # GET /person.json
  def index
    if params[:item_id]
      # @people = Person.where(:item_id => params[:item_id])
      @people = Item.find(params[:item_id]).people_recursive
    else
      @people = Person.all
    end
  end

  # GET /person/1
  # GET /person/1.json
  def show
  end

  # GET /person/new
  def new
    @person = Person.new
  end

  # GET /person/1/edit
  def edit
  end

  # POST /person
  # POST /person.json
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.json { render :show, status: :created, location: @person }
      else
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /person/1
  # PATCH/PUT /person/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.json { render :show, status: :ok, location: @person }
      else
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /person/1
  # DELETE /person/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.fetch(:person, {})
    end
end
