require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/dreams/new.html.erb" do
  include DreamsHelper

  before(:each) do
    assigns[:dream] = stub_model(Dream,
      :new_record? => true
    )
  end

  it "renders new dream form" do
    render

    response.should have_tag("form[action=?][method=post]", dreams_path) do
    end
  end
end
