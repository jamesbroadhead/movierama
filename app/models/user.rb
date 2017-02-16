class User < BaseModel
  include Ohm::Timestamps
  include Ohm::Validations

  attribute :name

  # Unique identifier for this user, in the form "{provider}|{provider-id}"
  attribute :uid
  index     :uid
  unique    :uid

  # Session token
  attribute :token
  index     :token

  # Submitted movies
  collection :movies, :Movie

  # Email address, from Github.
  # Since omniauth-1.2, this has been verified by github. However, our copy may
  #   have gone stale since the users last login.
  # https://github.com/intridea/omniauth-github/issues/36
  attribute :email

  attribute :updated_at # TODO: why isn't this needed for :created_at?

  # TODO: fix this
  # protected
  # def validate
  #  assert_email(:email)
  # end
end
