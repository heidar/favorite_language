class LookupsController < ApplicationController
  def lookup
    build_lookup

    return unless submitted?
    save_lookup
  end

  private

  def lookup_params
    lookup_params = params[:lookup] || ActionController::Parameters.new
    lookup_params.permit :username
  end

  def submitted?
    params[:commit] == 'Lookup'
  end

  def build_lookup
    @lookup = Lookup.new lookup_params
  end

  def save_lookup
    @lookup.save
  end
end
