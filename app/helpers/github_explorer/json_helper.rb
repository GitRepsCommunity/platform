# frozen_string_literal: true

module GithubExplorer
  module JsonHelper
    # ============================
    # Helpers
    # ============================
    def array?(obj)
      obj.is_a?(Array) && obj.length > 2
    end

    def obj?(obj)
      obj.is_a?(Array) && obj.length == 2
    end

    def rel?(key, val)
      key.end_with?('url') && val&.include?('api.github.com')
    end

    def depth(arr)
      return 0 unless arr.is_a?(Array)

      1 + depth(arr[0])
    end

    # ============================
    # Rendering
    # ============================
    def render_api_response(response)
      if depth(response) > 2
        render_json_array(response, -1)
      else
        render_json_object(response, -1)
      end
    end

    def render_json_object(obj, depth)
      if obj?(obj)
        obj_content(obj, depth)
      elsif array?(obj)
        render_json_array(obj, depth + 1)
      end
    end

    def render_json_array(arr, depth)
      content_tag(:div) do
        arr.each do |obj|
          concat render_json_object(obj, depth)
        end
      end
    end

    # ============================
    # Content tags
    # ============================
    def obj_content(obj, depth)
      key = obj[0]
      val = obj[1]
      content_tag(:div) do
        concat "#{key}: ".indent(depth * 4)
        concat val_content(val, depth)

        rel?(key, val) && (concat rel_link(key, val))
      end
    end

    def val_content(val, depth)
      if array?(val)
        render_json_array(val, depth + 1)
      else
        val
      end
    end

    def rel_link(key, val)
      rel = rel_parts(key, val)
      return unless rel[:params].length <= 1

      link_to "GET #{rel[:name]}",
              new_github_explorer_api_request_path(url: rel[:url]),
              class: 'ml-2 rounded-md bg-gray-100 text-blue-600'
    end

    def rel_parts(key, val)
      parts = val.split('{/')
      {
        name: key.gsub('_url', ''),
        url: parts[0],
        params: parts[1..].map { |p| p.gsub('}', '') }
      }
    end
  end
end
