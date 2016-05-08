###########################################
# Singleton class for calling mail service.
###########################################
module Services
  module MailServiceSao
    class << self
      
      @@logger = Logger.new('log/alert_errors.log')

      def send_email(user_email,template_name,merge_vars_hash,subject, request_id = nil)
        url = URI.parse("#{TaskbobConfig.alerts_service_url}/api/v0/email/send")
        params = {}
        params[:email] = user_email
        params[:test_email] = TaskbobConfig.test_email
        params[:template_name] = template_name
        params[:merge_vars] = merge_vars_hash.to_json
        params[:subject] = subject
        params[:request_id] = request_id
        begin
          response = Net::HTTP.post_form(url, params)
          if response.code == "200"
            body = JSON.parse(response.body)
            return true
          else
            return false
          end
        rescue Exception => e
          @@logger.info "Some Errors in sending Email #{e}"
        end
      end
    end
  end
end