class NoBalanceError < StandardError
  def initialize(user_id:)
    Rails.logger.info("[NoBalanceError] user_id: #{user_id}")
  end
end