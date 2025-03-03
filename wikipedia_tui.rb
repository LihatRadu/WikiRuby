require 'wikipedia'

module WikipediaHelper
  def self.fetch_page(querry)
    page = Wikipedia.find(querry)
    if page 
      {title: page.title, content: page.text}
    else
      nil
    end
  end
end

