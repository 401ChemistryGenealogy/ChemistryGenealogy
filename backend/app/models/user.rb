class User < ActiveRecord::Base
  validates :email, :password, :password_digest, presence: true
  # :password_digest is some type of bcrypt salt??
  PWORD_DIGST = "pword"


  def User.find_by_credentials(email, password)
    return User.find_by email: email, password: password
  end

  def User.new_user(password, email)
    unless User.exists?(:email => email)
      return User.new(password: password, email: email, password_digest: PWORD_DIGST)
    end
  end

  # https://quickleft.com/blog/keeping-your-json-response-lean-in-rails/
  # how to render fields selectively as json
  # for development purpose we'll just write the whole thing out, but this is
  # probably not the best idea for deployment
  #def as_json(options={})
  #  super(:only => [:email])
  #end
end
