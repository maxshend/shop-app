# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'List products', type: :system do
  it 'shows a greeting' do
    visit products_path

    expect(page).to have_content 'Greeting: Hello from react-rails.'
  end
end
