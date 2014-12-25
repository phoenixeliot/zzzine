class PagesController < Devise::SessionsController
	before_filter :init_attachment, only: [:new]

	private
  def init_attachment
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

end
