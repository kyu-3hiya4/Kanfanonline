class Public::GroupSearchesController < ApplicationController
  before_action :authenticate_user!

  def search
		@content = params[:content]
		@method = params[:method]
		@groups = Group.search(@content, @method)
	end
end
