class Custom::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]
  def new 
    #create a list of the last 12 users
    @last = User.last.id
    @last_users = []
    count = 0
    while count < 12
      @last_users << User.find_by_id(@last)
      @last -= 1
      count += 1
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
