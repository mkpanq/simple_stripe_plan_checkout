class BundleSyncJob < ApplicationJob
  queue_as :default

  def perform(payment_service_class:, bundle_repository_class:)
    payment_service = payment_service_class.constantize.new
    bundle_repository = bundle_repository_class.constantize.new

    data = payment_service.fetch_and_serialize_products
    bundle_repository.save_to_db(data)
  end
end
