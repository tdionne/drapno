require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/dreams/edit.html.erb" do
  include DreamsHelper

  before(:each) do
    assigns[:dream] = @dream = stub_model(Dream,
      :new_record? => false
    )
  end

  it "renders the edit dream form" do
    render

    response.should have_tag("form[action=#{dream_path(@dream)}][method=post]") do
    end
  end
end
