# frozen_string_literal: true

module HttpHelper
  def get(url:)
    u = URI.parse(url)
    req = Net::HTTP::Get.new(u.request_uri)
    http = Net::HTTP.new(u.host, u.port)
    http.use_ssl = (u.scheme == 'https')
    http.request(req)
  end

  def get_with_redirect(url:)
    redirect = get(url:)
    get(url: redirect.header['location'])
  end
end
