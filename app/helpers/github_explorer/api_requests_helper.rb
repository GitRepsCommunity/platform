# frozen_string_literal: true

module GithubExplorer
  module ApiRequestsHelper
    include JsonHelper

    def resource_options
      GithubExplorer::ApiRequest.resources.map do |k, v|
        label = k == 'url' ? "#{k.titleize} (must specify url)" : k.titleize
        [label, GithubExplorer::ApiRequest.resources.key(v)]
      end
    end

    def tag_show_item(api_request)
      tag.div class: 'mt-6' do
        concat tag_list_item_attrs(api_request)
        concat tag.pre render_api_response(api_request.response), class: 'bg-gray-600 p-5'
      end
    end

    def tag_list_item(api_request)
      tag.div class: 'mt-6' do
        concat tag_list_item_attrs(api_request)
        concat tag_list_item_links(api_request)
        concat tag.hr class: 'mt-6'
      end
    end

    def tag_list_item_attrs(api_request)
      tag.div class: 'mt-6' do
        concat tag.div "ID: #{api_request.id}"
        concat tag.div "Requested by: #{api_request.user.github_username}"
        concat tag_resource_or_url(api_request)
        concat tag.div "Created: #{api_request.created_at}"
      end
    end

    def tag_resource_or_url(api_request)
      if api_request.url?
        tag.div "Url: #{api_request.url}"
      else
        tag.div "Resource: #{api_request.resource.titleize}"
      end
    end

    def tag_list_item_links(api_request)
      tag.div class: 'flex justify-between mt-6' do
        concat link_to 'Show', api_request, class: 'text-blue-600'
        concat button_to 'Delete',
                         github_explorer_api_request_path(api_request),
                         method: :delete,
                         class: 'text-red-600'
      end
    end
  end
end
