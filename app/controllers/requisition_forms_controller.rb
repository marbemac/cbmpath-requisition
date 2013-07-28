require 'net/ftp'
require 'double_bag_ftps'

class RequisitionFormsController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource

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
    @requisition_form = RequisitionForm.new(:collection_date => Date.today)
    @requisition_form.patient = Patient.new

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
    # build patient
    unless params[:requisition_form][:patient_attributes][:id].blank?
      @patient = Patient.find(params[:requisition_form][:patient_attributes][:id])
      authorize! :read, @patient
      params[:requisition_form].delete(:patient_attributes)
    end

    @requisition_form = current_user.requisition_forms.new(params[:requisition_form])
    @requisition_form.patient = @patient if defined? @patient

    respond_to do |format|
      if @requisition_form.save

        @requisition_form.send_via_sftp

        format.html { redirect_to @requisition_form, notice: 'Requisition form was successfully created.' }
        format.json { render json: @requisition_form, status: :created, location: @requisition_form }
      else
        format.html { render action: "new" }
        format.json { render json: @requisition_form.errors, status: :unprocessable_entity }
      end
    end
  end
end
