class LookupsController < ApplicationController
  # We use a GET method to do the lookup, no server resources are being
  # updated.
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

  # Since we're doing an HTTP GET on the same route as we display the form,
  # we check this built in Rails param to see if the user submitted the form.
  def submitted?
    params[:commit] == 'Lookup'
  end

  def build_lookup
    @lookup = Lookup.new lookup_params
  end

  # Save the virtual model. No persistence is done, it just fires validations.
  def save_lookup
    @lookup.save
  end
end
