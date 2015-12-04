require 'test_helper'

class InquiryTest < ActiveSupport::TestCase
  test "should get content hash" do
    hash = { 'a' => '1', 'b' => '2', 'c' => '3' }
    inquiry = Inquiry.new
    inquiry.content = hash.to_json
    assert_equal hash, inquiry.content_hash
  end
end
