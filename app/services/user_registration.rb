# Given an Omniauth hash, finds or creates Users.
class UserRegistration
  def initialize(auth_hash)
    @ran = @user = @created = nil
    @auth_hash = auth_hash
  end

  # A saved user instance for the `auth_hash`
  def user
    _run
    @user
  end

  # Return whether the user was created by the service.
  #
  def created?
    _run
    @created
  end

  private

  def _run
    @ran && return
    uid = '%s|%s' % [
      @auth_hash['provider'],
      @auth_hash['uid']
    ]

    if user = User.find(uid: uid).first
      # fill in emails from users who don't have them, or update the address on
      #   file, in case it's changed github-side
      user.email = @auth_hash['info']['email'],
                   user.updated_at = Time.current.utc.to_i
      @user    = user
      @created = false

      user.save # TODO: latency impact?
    else
      @user = User.create(
        uid:        uid,
        name:       @auth_hash['info']['name'],
        email:      @auth_hash['info']['email'],
        created_at: Time.current.utc.to_i,
        updated_at: Time.current.utc.to_i
      )
      @created = true
    end

    @ran = true
  end
end
