class ContactListsController < ApplicationController
  before_action :set_contact_list, only: %i[index search]
  before_action :set_contact, only: %i[edit show update destroy]

  # GET /contact_lists
  def index
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /contact_lists/new
  def new
    @contact_list = ContactList.new
    @url = contact_lists_path
    respond_to do |format|
      format.js
    end
  end

  # GET /contact_lists/:id/edit
  def edit
    @url = contact_list_path(@contact_list.id)
    respond_to do |format|
      format.js
    end
  end

  # GET /contact_lists/:id
  def show
    # @contact_list = ContactList.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  # POST /contact_lists
  def create
    @contact_list = ContactList.new(contact_listing_params)
    if @contact_list.save
      @contact_lists = set_contact_list
      respond_to do |format|
        format.js { render 'index', status: :created }
      end
    else
      respond_to do |format|
        @errors = @contact_list.errors
        format.js { render 'new', status: :unprocessable_entity }
      end
    end
  end

  # PUT /contact_lists/:id
  def update
    if @contact_list.update(contact_listing_params)
      @contact_lists = set_contact_list
      respond_to do |format|
        format.js { render 'index', status: :ok }
      end
    else
      respond_to do |format|
        @errors = @contact_list.errors
        format.js { render 'edit', status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_lists/:id
  def destroy
    @contact_list.destroy
    if @contact_list.destroyed?
      @contact_lists = set_contact_list
      respond_to do |format|
        format.js { render 'index', status: :ok }
      end
    else
      render json: { errors: { alert: 'Contact could not be deleted.' } }, status: :unprocessable_entity
    end
  end

  # GET /contact_lists/search
  def search
    render json: @contact_lists
  end

  private

  def set_contact
    @contact_list = ContactList.find(params[:id])
  end

  def set_contact_list
    value = search_params && search_params[:q] && search_params[:q][:name_or_number_cont]
    @contact_lists = ContactList.search_contact_list(value)
    # @contact_lists = ContactList.ransack(search_params[:q]).result(distinct: true).order('name ASC')
  end

  def contact_listing_params
    params.require(:contact_list).permit(:name, :number)
  end

  def search_params
    params.permit(q: %i[name_cont number_cont name_or_number_cont])
  end
end
