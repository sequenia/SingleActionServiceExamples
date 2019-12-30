class Api::V1::BaseController < ApplicationController
  include JsonHelper

  layout 'application.json.erb'

  # Skipping defaul Devise authentification
  skip_before_action :verify_authenticity_token
end
