class CheckoutController < ApplicationController
  # TODO: Not sure - try to look for better solution
  skip_before_action :verify_authenticity_token, only: [ :checkout_status ]
  skip_before_action :authorize, only: [ :checkout_status ]

  def get_checkout
    session = checkout_service.get_bundle_checkout(bundle_id: params[:bundle_id], user_email: current_user.email)

    redirect_to session.url, status: 303, allow_other_host: true
  end

  def checkout_status
    checkout_service.proceed_checkout_event_status(request: request)

    # Normal returns 204, need to return 200, or 400 if somethings wrong
    # TODO: Based on this - checkout will redirect to success or cancel url
  end

  private

  def checkout_service
    @checkout_service ||= CheckoutService.new(
      payment_service: Payments::StripePaymentService.new
      )
  end
end
