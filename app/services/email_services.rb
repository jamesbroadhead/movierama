

# For test/debug/early staging, implements the mailer interface, but does not
# send email
class LogOnlyEmail
  def send_email(_from, to, subject, _text)
    # TODO: increment a stat here & add an alert if the stat is seen
    #   in production
    Rails.logger.debug 'NullSending an email to ' + to +
                       ' with subject: ' + subject
  end
end

# Email-sending via Mailgun, an email-sending company.
#
# This class is not intended to be used directly, use higher-level
#   `Email` instead.
class MailgunEmail < ActionMailer::Base
  def send_email(_from, to, subject, text)
    Rails.logger.debug 'Sending mail via Mailgun'

    @domain = Rails.configuration.email_mailgun_domain
    @api_key = Rails.configuration.email_mailgun_api_key

    message_params = {
      from: 'jamesbroadhead@gmail.com', # from,
      to: to,
      subject: subject,
      text: text
    }

    mg_client = Mailgun::Client.new @api_key
    mg_client.send_message @domain, message_params
  end
end
