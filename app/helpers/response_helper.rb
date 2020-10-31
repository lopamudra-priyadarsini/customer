module ResponseHelper

  def success_response(*args)
    response_data, http_status = Response.new(*args).success
    render json: response_data, status: http_status
  end

  def error_response(*args)
    response_data, http_status = Response.new(*args).error
    render json: response_data, status: http_status
  end

  class Response
    def initialize(args)
      @status_msg = args[:status] 
      @data = args[:data]
      @message = args[:message]
      @http_status = args[:http_status]
      @params = args[:params]
      @logger_level = args[:logger_level]
      @log = args[:log]
      @response_data = {}
    end

    def success
      @status_msg ||= 'success'
      @http_status ||= :ok
      return  response_data, @http_status
    end

    def error
      @status_msg ||= 'error'
      @http_status ||= :bad_request
      @logger_level ||= :warn
      @log ||= true
      Rails.logger.send(@logger_level, "RESPONSE : #{@http_status} - #{@params}") if @log
      return response_data, @http_status
    end

    private
    
    def response_data
      @response_data.merge!({ status: @status_msg }) if @status_msg.present?
      @response_data.merge!({ message: @message }) if @message.present?
      @response_data.merge!({ data: @data }) if @data.present?
      @response_data
    end
  end
end