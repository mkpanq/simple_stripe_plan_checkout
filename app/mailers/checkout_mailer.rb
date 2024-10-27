class CheckoutMailer < ApplicationMailer
  def success_email
    @user = params[:user]
    @order = params[:order]
    @bundle = params[:bundle]

    mail(to: @user.email, subject: "Thank you for your purchase!")
  end
end
