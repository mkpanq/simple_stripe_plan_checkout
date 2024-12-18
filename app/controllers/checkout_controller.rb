class CheckoutController < ApplicationController
  # TODO: Not sure - try to look for better solution
  skip_before_action :verify_authenticity_token, only: [ :checkout_status ]
  skip_before_action :authorize, only: [ :checkout_status ]

  def create_new_checkout_session
    session = checkout_service.create_new_checkout_session(bundle_id: params[:bundle_id], user_email: current_user.email)

    redirect_to session.url, status: 303, allow_other_host: true
  end

  def continue_existing_checkout_session
    session = checkout_service.get_existing_checkout_session(params[:session_id])

    redirect_to session.url, status: 303, allow_other_host: true
  end

  def checkout_status
    checkout_service.proceed_checkout_event_status(request: request)

    head :ok
  rescue => error
    render json: { error: error.message }, status: error.try(:status) || 500
  end

  def success_status
    @bundle_data = get_bundle_data_from_session
  end

  def cancel_status
    @bundle_data = get_bundle_data_from_session
  end

  private

  def get_bundle_data_from_session
    session_id = params[:session_id]

    checkout_service.get_bundle_data_from_session_id(session_id)
  end

  def checkout_service
    @checkout_service ||= CheckoutService.new(
      payment_service: Payments::StripePaymentService.new,
      order_service: OrdersService.new(
        order_repository: OrdersRepository.new,
        user_repository: UserRepository.new,
        bundle_repository: BundleRepository.new
      )
    )
  end
end
