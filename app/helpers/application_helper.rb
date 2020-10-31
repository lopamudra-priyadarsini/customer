module ApplicationHelper
	def generate_server_error_response(e, request_id = nil, params={})
    logger.error("Time: #{Time.now}, Message: #{e.message}, Backtrace: #{e.backtrace.join("\n")}")
    render json: {
        status: 'error',
        errors: [e.message],
        message: "Something went wrong"
    }, status: 500 and return
  end

  def response_generator(data, status)
    response = OpenStruct.new
    if data.present? || status.eql?('true') || status.eql?(true) || status.eql?('success')
      response.status = 'success'
      response.status_message = 'your request was successfully taken'
    else
      response.status = status
      response.status_message = 'your request was not taken'
    end
    response.data = data
    response
  end
end
