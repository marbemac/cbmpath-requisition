class Emailer < ActionMailer::Base

  def ftp_fail(req_id)
    @requisition_form = RequisitionForm.find(req_id)
    mail(
      :from => "matt.c.mccormick@gmail.com",
      :to => "matt.c.mccormick@gmail.com, marbemac@gmail.com",
      :subject => "Requisition FTP Error: #{@requisition_form.id}"
    )
  end

end
