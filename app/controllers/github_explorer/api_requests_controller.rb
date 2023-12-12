# frozen_string_literal: true

module GithubExplorer
  class ApiRequestsController < ApplicationController
    before_action :set_new_params, only: %i[new]
    before_action :set_github_explorer_api_request, only: %i[show destroy]

    def index
      @github_explorer_api_requests = GithubExplorer::ApiRequest.where(user: current_user)
    end

    def show; end

    def new
      @github_explorer_api_request = GithubExplorer::ApiRequest.new(@new_params)
    end

    def create
      create_params = api_request_params.merge(user: current_user)
      @github_explorer_api_request = GithubExplorer::ApiRequest.new(create_params)

      if @github_explorer_api_request.send_request_and_save!
        redirect_to github_explorer_api_request_url(@github_explorer_api_request)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @github_explorer_api_request.destroy

      redirect_to github_explorer_api_requests_url
    end

    private

    def set_github_explorer_api_request
      @github_explorer_api_request = GithubExplorer::ApiRequest.find(params[:id])
    end

    def api_request_params
      params.require(:github_explorer_api_request).permit(:resource, :query, :url)
    end

    def set_new_params
      return unless params[:url]

      @new_params = { url: params[:url], resource: 'url' }
    end
  end
end
