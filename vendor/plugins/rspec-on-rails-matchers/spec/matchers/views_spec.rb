require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')
require 'spec/rails/matchers/views'

class ViewMatchers
  include Spec::Rails::Matchers
  include Spec::Matchers
end

describe "ActionView template matchers" do
  before(:each) do
    @matchers = ViewMatchers.new
  end
  
  describe "Forms PUTting to a resource" do
    before(:each) do
      @sample_output = <<-EOF
<form action="/path/to/resource/1" class="edit_page" id="edit_page_1" method="post"><div style="margin:0;padding:0"><input name="_method" type="hidden" value="put" /><input name="authenticity_token" type="hidden" value="token" /></div></form>
<form action="/path/to/resource" class="edit_page" id="edit_page_1" method="post"><input name="authenticity_token" type="hidden" value="token" /></div></form>
      EOF
    end
    
    it "should be able to detect a form putting to a resource" do
      @sample_output.should @matchers.have_form_putting_to('/path/to/resource/1')
    end
    
    it "should NOT misreport of POST form" do
      @sample_output.should_not @matchers.have_form_putting_to('/path/to/resource')
    end
  end
  
  describe "Forms DELETEing a resource" do
    before(:each) do
      @sample_output = <<-EOF
<form action="/path/to/resource/1" class="edit_page" id="edit_page_1" method="post"><div style="margin:0;padding:0"><input name="_method" type="hidden" value="delete" /><input name="authenticity_token" type="hidden" value="token" /></div></form>
<form action="/path/to/resource" class="edit_page" id="edit_page_1" method="post"><input name="authenticity_token" type="hidden" value="token" /></div></form>
      EOF
    end

    it "should be able to detect a form putting to a resource" do
      @sample_output.should @matchers.have_form_deleting('/path/to/resource/1')
    end

    it "should NOT misreport of POST form" do
      @sample_output.should_not @matchers.have_form_deleting('/path/to/resource')
    end
  end
end