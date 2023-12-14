# frozen_string_literal: true

module GithubExplorer
  module JsonHelper
    def tag_json(response)
      return tag_json_array(response) if response.is_a? Array

      tag.pre class: 'bg-gray-900 p-5 text-rose-400' do
        concat tag_obj obj: response, indent: 0
      end
    end

    def tag_json_array(response)
      tag.pre class: 'bg-gray-900 p-5 text-rose-400' do
        response.each do |resp|
          concat tag_obj obj: resp, indent: 0
          concat tag.hr class: 'my-6'
        end
      end
    end

    def tag_obj(obj:, indent:)
      tag.div do
        obj.each { |key, val| concat tag_attr(key, val, indent) }
      end
    end

    def tag_attr(key, val, indent)
      tag.div do
        concat "#{key}:".indent(indent * 4)
        if val.is_a? Hash
          concat tag_obj(obj: val, indent: indent + 1)
        else
          concat tag_syntax_highlighting(val)
        end
        concat rel_link(key, val)
      end
    end

    def rel_link(key, val)
      return unless key.is_a?(String) && key.end_with?('url') && val&.include?('api.github.com')

      link_to "GET #{key}",
              new_github_explorer_api_request_path(url: val),
              class: 'px-1 ml-2 rounded-md text-blue-600 hover:underline'
    end

    def tag_syntax_highlighting(val)
      tag_integer(val) ||
        tag_boolean(val) ||
        tag_datetime(val) ||
        (tag.span val, class: 'ml-1 text-green-400')
    end

    def tag_integer(val)
      return unless val.is_a? Integer

      tag.span val, class: 'ml-1 text-blue-400'
    end

    def tag_boolean(val)
      return unless [true, false].include? val

      tag.span val, class: 'ml-1 text-orange-400'
    end

    def tag_datetime(val)
      begin
        val.to_datetime
      rescue Date::Error, NoMethodError
        return
      end
      tag.span val, class: 'ml-1 text-yellow-400'
    end
  end
end
