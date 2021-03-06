class CommunityPartnersMailer < ActionMailer::Base

  default :from => "forms@chicagoideas.com"
  default :to => "brooke@chicagoideas.com"
  default :bcc => "john@kohactive.com"
  default :subject => "Community Partners Form Submission"
  
  def send_form(form, filename)
    @form = form
    attachments[filename] = File.read("#{Rails.root}/tmp/#{filename}");
    mail()
  end
  
end
