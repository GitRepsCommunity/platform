# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show edit update destroy]

  # GET /profiles or /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1 or /profiles/1.json
  def show; end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit; end

  # POST /profiles or /profiles.json
  def create
    @profile = Profile.new(profile_params.merge(user: current_user, avatar_url: current_user.profile_pic_url))

    respond_to do |format|
      if @profile.save
        format.html { redirect_to profile_url(@profile), notice: I18n.t('notices.profile_created') }
        format.json { render :show, status: :created, location: @profile }
      else
        handle_unsuccessful_save(format)
      end
    end
  end

  def handle_unsuccessful_save(format)
    format.html { render :new, status: :unprocessable_entity }
    format.json { render json: @profile.errors, status: :unprocessable_entity }
  end

  # PATCH/PUT /profiles/1 or /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to profile_url(@profile), notice: I18n.t('notices.profile_updated') }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1 or /profiles/1.json
  def destroy
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to profiles_url, notice: I18n.t('notices.profile_destroyed') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = Profile.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def profile_params
    params.require(:profile).permit(:description, :avatar_url)
  end
end
