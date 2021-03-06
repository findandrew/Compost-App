class MembersController < ApplicationController
  # THESE NEED SOME WORK BEFORE THEY CAN BE UNCOMMENTED!!!
  before_action :logged_in_user, only: [:create, :index, :show]
  before_action :correct_user, only: [:index, :show]

  # Display members in pagination
  def index
    @user = User.find(params[:user_id])
    @lat = cookies[:latitudine].nil? ? '0.00' : cookies[:latitudine]
    @long = cookies[:longitudine].nil? ? '0.00' : cookies[:longitudine]
    @members = @user.members.paginate(page: params[:page])

    # If no members, set flash and exit
    if @members.empty?
      flash.now[:info] = "Create your first member by clicking the 'Add Member' button!"
      return
    end

    # Check for 'order' param in url
    if params[:order]
      if params[:order] == 'first'
        # Order by first name
        @members = @user.members.order("LOWER(first\_name) asc").paginate(page: params[:page])
      elsif params[:order] == 'last'
        # Order by last name
        @members = @user.members.order("LOWER(last\_name) asc").paginate(page: params[:page])
      elsif params[:order] == 'locale'
        # Order by location
        @members = @user.members.near([@lat, @long], 50).paginate(page: params[:page])
        if @members.empty?
          flash.now[:info] = "No members within 50 miles of your current location. Try ordering by first or last name!"
        end
      end
    else
      # If no 'order' param, default to order by location
      @members = @user.members.near([@lat, @long], 50).paginate(page: params[:page])
      if @members.empty?
        flash.now[:info] = "No members within 50 miles of your current location. Try ordering by first or last name!"
      end
    end
  end

  # Member profile
  def show
    @member = Member.find(params[:id])
  end

  # Make new member
  def new
  end

  def create
    @member = current_user.members.build(member_params)
    if @member.save
      flash[:success] = "Member '#{@member.first_name} #{@member.last_name}' created!"
      redirect_to @current_user
    end
  end

  private

    def member_params
      params.require(:member).permit(:first_name, :last_name, :address_line_one, :address_line_two)
    end

    # Confirms the correct user
    def correct_user
      @user = User.find(params[:user_id])
      redirect_to root_url unless current_user?(@user)  # app/helpers/session_helper.rb
    end
end
