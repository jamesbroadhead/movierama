
require 'email_services'

# Organises and sends email, selecting a provider based on config
class Email
  def send_email(user, email_type, *_args)
    # TODO: this would be way better if this injected movie info into the email
    # TODO: move this into a map of type => details
    if email_type == 'vote_received'
      @subject = 'One of your movies got clicked!'
      @text = 'It sure did!'
      @from = 'info@movierama.com'
    else
      logger.error 'Unknown email type: #{email_type}'
      return
    end

    # TODO: rate-limit sending to a particular address
    @to = user.email

    if @to.nil?
      # the user who created the movie has no email address on file
      Rails.logger.info 'No email address for ' + user.uid
      return
    end

    # TODO: Don't try/catch on critical emails -- eg. security-related
    # TODO: do this async (requires activejob / rails 4.2)
    # TODO: should not send immediately - give grace period for active
    #   user to undo
    begin
      _mailer.send_email(@from, @to, @subject, @text)
    rescue StandardError
      Rails.logger.error 'Failed to send ' + email_type + ' to ' + user.uid
      # TODO: log enough to debug
    end
  end

  # TODO: Don't pick a mailer from an available set & send the thing -
  #   instead, DI in a mailer at the config stage
  def _mailer
    provider = Rails.configuration.email_provider

    # TODO: it would be nice to be able to switch these dynamically
    if provider == 'log_only'
      @mailer = LogOnlyEmail.new
    elsif provider == 'mailgun'
      @mailer = MailgunEmail
    else
      Rails.logger.debug 'No email provider configured. Got: ' + provider
      # TODO: a stat & an alert if this is seen in prod
    end
  end
end
