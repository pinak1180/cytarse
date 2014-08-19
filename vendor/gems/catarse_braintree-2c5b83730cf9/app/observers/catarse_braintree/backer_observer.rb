class CatarseBraintree::BackerObserver < ActiveRecord::Observer
  observe :backer

  def from_requested_refund_to_refunded
    Rails.logger.debug "[Braintree] Queued refund job"
    RefundWorker.perform_async(backer.id)
  end

  def from_confirmed_to_refunded
    Rails.logger.debug "[Braintree] Queued refund job"
    RefundWorker.perform_async(backer.id)
  end
end


