# frozen_string_literal: true

module Helpers
  module System
    def failed_destroy(klass)
      obj = instance_double klass

      allow(klass).to receive(:find_by).and_return obj
      allow(obj).to receive(:destroy).and_return false
      allow(obj).to receive(:errors).and_return(
        ActiveModel::Errors.new(obj).tap { |e| e.add(:base, '') }
      )
    end
  end
end
