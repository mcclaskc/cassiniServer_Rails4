class PagesController < ApplicationController
	def index
  		@admin = is_admin?
	end

	def about
	end
end
