class Email < ActionMailer::Base
  default from: "nguyennghia2407@gmail.com"

  def registration_confirmation(user)
  	mail(:to => user.email, :subject => "register successful")
  end
end
