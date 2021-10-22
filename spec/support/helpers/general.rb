# frozen_string_literal: true

module Helpers
  module General
    def failed_destroy(klass)
      obj = instance_double klass

      allow(klass).to receive(:find_by).and_return obj
      allow(obj).to receive(:destroy).and_return false
      fake_error obj, :base, ''
    end

    def fake_error(obj, attr, message)
      allow(obj).to receive(:errors).and_return(
        ActiveModel::Errors.new(obj).tap { |e| e.add(attr, message) }
      )
    end
  end
end
