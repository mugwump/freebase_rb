require "freebase_rb"

describe FreebaseRb::API do
  
  before :all do
    FreebaseRb::Config.api_key "AIzaSyBhsujV4cTbYov4dW-nzGluwx0nZav4reU"
    FreebaseRb::Config.cache(:is_active => false)
    
  end
  
  let (:api) { FreebaseRb::API}

  
  describe ".get" do
      it "returns a topic with the correct name" do
        api.get("/en/the_beatles").name.should eql "The Beatles"
      end
    end

  describe ".search" do
    it "returns a hash with at least one correct result" do
      api.search(:query => "The Beatles").any? { |result| result.id == "/en/the_beatles" }.should be_true
    end
  end

  describe ".full_resolve" do
    it "returns a hash with at least one correct result" do
      topic = api.search("Elvis Presley").first

      topic.should_not be_nil
      topic.get_property("name").should eql "Elvis Presley"
      topic.get_property("notable")["name"].should eql "Singer"
      topic.description.length.should > 100
    end
  end
  

  describe ".topic" do
    it "returns a topic with the correct name" do
      mql = {
        :id => '/en/the_beatles',
        :name => nil
      }
      api.topic(mql).name.should eql "The Beatles"
    end

    it "returns array properties as an array" do
      mql = {
        :id => '/en/the_beatles',
        :'/music/artist/genre' => [{:id => nil, :name => nil}]
      }
      api.topic(mql)["/music/artist/genre"].should include({"name" => "Rock music", "id" => "/en/rock_music"})
    end
  end


end
