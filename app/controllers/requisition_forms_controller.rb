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
    #@requisition_form.doctor = Doctor.new
    #@requisition_form.doctor2 = Doctor.new

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
    # Get rid of the not-required doctor if they didn't enter one
    #params[:requisition_form].delete(:doctor2_attributes) if params[:requisition_form][:doctor2_attributes][:name].blank?

    ## build doctor 1
    #unless params[:requisition_form][:doctor_attributes][:id].blank?
    #  @doctor = Doctor.find(params[:requisition_form][:doctor_attributes][:id])
    #  authorize! :read, @doctor
    #  params[:requisition_form].delete(:doctor_attributes)
    #end
    #
    ## build doctor 2
    #if params[:requisition_form][:doctor2_attributes] && !params[:requisition_form][:doctor2_attributes][:id].blank?
    #  @doctor2 = Doctor.find(params[:requisition_form][:doctor2_attributes][:id])
    #  authorize! :read, @doctor2
    #  params[:requisition_form].delete(:doctor2_attributes)
    #end

    # build patient
    unless params[:requisition_form][:patient_attributes][:id].blank?
      @patient = Patient.find(params[:requisition_form][:patient_attributes][:id])
      authorize! :read, @patient
      params[:requisition_form].delete(:patient_attributes)
    end

    @requisition_form = current_user.requisition_forms.new(params[:requisition_form])
    #@requisition_form.doctor = @doctor if defined? @doctor
    #@requisition_form.doctor2 = @doctor2 if defined? @doctor2
    @requisition_form.patient = @patient if defined? @patient

    respond_to do |format|
      if @requisition_form.save

        begin
          file = File.open("/tmp/#{@requisition_form.id}.txt","w") do |f|
            f.write(@requisition_form.to_json)
          end
          ftps = DoubleBagFTPS.new
          ftps.debug_mode = true
          ftps.ssl_context = DoubleBagFTPS.create_ssl_context(:verify_mode => OpenSSL::SSL::VERIFY_NONE)
          ftps.connect('us1.hostedftp.com')
          ftps.login("marbemac@gmail.com", "giants22")
          ftps.passive = true
          ftps.puttextfile("/tmp/#{@requisition_form.id}.txt")
          ftps.quit()
        rescue
          Emailer.ftp_fail(@requisition_form.id).deliver
        end

        format.html { redirect_to @requisition_form, notice: 'Requisition form was successfully created.' }
        format.json { render json: @requisition_form, status: :created, location: @requisition_form }
      else
        format.html { render action: "new" }
        format.json { render json: @requisition_form.errors, status: :unprocessable_entity }
      end
    end
  end
end
