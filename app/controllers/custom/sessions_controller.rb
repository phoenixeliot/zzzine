class Custom::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]
  def new 
    #create a list of the last 12 users
    if User.count != 0
      @last = User.last.id
      @last_users = []
      count = 0
      while count < 9
        @last_users << User.first
        count += 1
      end
    else
      @last_users = []
    end
    
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
