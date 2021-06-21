module Externable
  extend ActiveSupport::Concern

  included do
    before_validation :generate_external_id, on: :create
    validates         :external_id, presence: true, uniqueness: true
  end

  def generate_external_id
    loop do
      self.external_id = SecureRandom.hex(5)
      break unless self.class.find_by(external_id: external_id)
    end
  end
end
