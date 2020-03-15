class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart=[]


  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if @@cart.empty?
      resp.write "Your cart is empty"
    end
      if req.path.match(/cart/)
        @@cart.each do |c|
          resp.write "#{c}\n"
        end
        if req.path.match(/items/)
          @@items.each do |item|
            resp.write "#{item}\n"
          end
        elsif req.path.match(/search/)
          search_term = req.params["q"]
          resp.write handle_search(search_term)
        end

      elsif req.path.match(/add/)

          add_term = req.params["q"]

          if @@items.none?
            resp.write "We don't have that item"
          elsif @@items.include?(add_term)
             @@cart<<add_term
             resp.write "added #{added_term}\n"
        end
        else resp.write "Path Not Found"
      end
      resp.finish
    end


  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
