class App < Sinatra::Application

  def connections_header
    props={}
    props["Connection"]={value: lambda{|x| "#{x.adapter} #{x.host}/#{x.database}"}, link: lambda{|x| "/database/#{x.id}"}}
    props
  end

  get "/connections" do
    haml :collection, locals:{title: "Connetions", model: {header: connections_header, data: Database.order(Sequel.desc(:last_used)).all}}
  end
end

