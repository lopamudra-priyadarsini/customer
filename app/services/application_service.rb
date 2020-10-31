# Advanced service class which helps manage response
class ApplicationService < BaseService
  
  include ApplicationHelper
  attr_reader :response

  def initialize(options = {})
    @response = OpenStruct.new
  end

  def self.call(*args)
    service_object = self.new(*args.map(&:to_h).map(&:with_indifferent_access))
    service_object.call
    service_object.response
  end

  protected

  def find(model, object, options = {})
    attribute = options[:attribute].presence || :id
    return object if object.is_a?(model)
    model.find_by(attribute.to_sym => object)
  end

  def update_response(options)
    @response.status = options[:status]
    @response.message = options[:message]
  end

  def success_response(options = {})
    @response.status =  options[:status] || 'success'
    @response.message = options[:message]
    @response.data = options[:data]
    @response['success?'] = true
  end

  def error_response(options = {})
    @response.http_status = options[:http_status] || 400
    @response.status = options[:status] || 'error'
    @response.message = options[:message]
    @response.data = options[:data]
    @response['success?'] = false
  end

  def async_response(options)
    @response.status = options[:status]
    @response.status_message = options[:status_message]
    @response.success_file = options[:success_file]
    @response.failure_file = options[:failure_file]
    @response.success_count = options[:success_count]
    @response.failure_count = options[:failure_count]
    @response.input_file = options[:input_file]
  end
end
