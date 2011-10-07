module SessionsHelper
  
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    current_user = user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user 
    @current_user ||= user_from_remember_token    
    # or i can type @current_user = @current_user || user_from_remember_token
  end
  
  def signed_in?
    !current_user.nil? 
  end
  
  def sign_out
    cookies.delete(:remember_token)
    current_user = nil 
  end
  
  private
  
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token) # the * sign unwraps the puser.id, user.salt] element into 2 elements
    end
    
    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
end
