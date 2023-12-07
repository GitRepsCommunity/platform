# frozen_string_literal: true

module GithubExplorer
  class ApiRequestsController < ApplicationController
    before_action :set_new_params, only: %i[new]
    before_action :set_octokit_client, only: %i[create]
    before_action :set_github_explorer_api_request, only: %i[show destroy]

    def index
      @github_explorer_api_requests = GithubExplorer::ApiRequest.where(user: current_user)
    end

    def show; end

    def new
      @github_explorer_api_request = GithubExplorer::ApiRequest.new(@new_params)
      @resource_options = GithubExplorer::ApiRequest.resources.map do |k, v|
        [k.titleize, GithubExplorer::ApiRequest.resources.key(v)]
      end
    end

    def create
      response = get_response_by_resource(github_explorer_api_request_params)
      create_params = github_explorer_api_request_params.merge(user: current_user, response:)
      @github_explorer_api_request = GithubExplorer::ApiRequest.new(create_params)

      if @github_explorer_api_request.save
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

    def github_explorer_api_request_params
      params.require(:github_explorer_api_request).permit(:resource, :query, :url)
    end

    def set_new_params
      return unless params[:url]

      @new_params = { url: params[:url], resource: 'url' }
    end

    def set_octokit_client
      @client = Octokit::Client.new(access_token: current_user.github_token, per_page: 100)
    end

    def get_response_by_resource(params)
      case params[:resource]
      when 'url'
        @client.get(params[:url])
      when 'repositories'
        @client.repositories
      when 'organizations'
        @client.organizations
      when 'user'
        @client.user
      end
    end
  end
end
