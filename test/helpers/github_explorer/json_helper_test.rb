# frozen_string_literal: true

require 'test_helper'

module GithubExplorer
  class JsonHelperTest < ActionView::TestCase
    test 'tag_datetime returns nil for invalid datetimes' do
      assert_nil tag_datetime(nil)
      assert_nil tag_datetime(123)
      assert_nil tag_datetime('')
      assert_nil tag_datetime('not a datetime')
      datetime_parse_char_limit = 129
      assert_nil tag_datetime('a' * datetime_parse_char_limit)
    end

    test 'tag_datetime returns tag for datetimes' do
      datetime_str = DateTime.now.to_s
      assert_dom_equal %(<span class="ml-1 text-yellow-400">#{datetime_str}</span>), tag_datetime(datetime_str)
    end
  end
end
