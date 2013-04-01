class RequisitionFormsController < ApplicationController
  # GET /requisition_forms
  # GET /requisition_forms.json
  def index
    @requisition_forms = RequisitionForm.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @requisition_forms }
    end
  end

  # GET /requisition_forms/1
  # GET /requisition_forms/1.json
  def show
    @requisition_form = RequisitionForm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @requisition_form }
      format.pdf do
        render :pdf => "file_name"
      end
    end
  end

  # GET /requisition_forms/new
  # GET /requisition_forms/new.json
  def new
    @requisition_form = RequisitionForm.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @requisition_form }
    end
  end

  # GET /requisition_forms/1/edit
  def edit
    @requisition_form = RequisitionForm.find(params[:id])
  end

  # POST /requisition_forms
  # POST /requisition_forms.json
  def create
    @requisition_form = RequisitionForm.new(params[:requisition_form])

    respond_to do |format|
      if @requisition_form.save
        format.html { redirect_to @requisition_form, notice: 'Requisition form was successfully created.' }
        format.json { render json: @requisition_form, status: :created, location: @requisition_form }
      else
        format.html { render action: "new" }
        format.json { render json: @requisition_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /requisition_forms/1
  # PUT /requisition_forms/1.json
  def update
    @requisition_form = RequisitionForm.find(params[:id])

    respond_to do |format|
      if @requisition_form.update_attributes(params[:requisition_form])
        format.html { redirect_to @requisition_form, notice: 'Requisition form was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @requisition_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requisition_forms/1
  # DELETE /requisition_forms/1.json
  def destroy
    @requisition_form = RequisitionForm.find(params[:id])
    @requisition_form.destroy

    respond_to do |format|
      format.html { redirect_to requisition_forms_url }
      format.json { head :no_content }
    end
  end
end
