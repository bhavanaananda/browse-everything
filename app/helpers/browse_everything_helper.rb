module BrowseEverythingHelper

  def array_to_hidden_fields(array,key)
    fields = array.to_query(key).split(Rack::Utils::DEFAULT_SEP).collect do |pair|
      key,value=pair.split('=', 2).map { |str| Rack::Utils.unescape(str) }
      hidden_field_tag(key,value)
    end
    fields.join("\n").html_safe
  end

  def render_files
    if provider.present?
      if provider.authorized?
        begin
          render 'files' 
        rescue BrowseEverything::NotAuthorized
          render 'auth'
        end
      else
        render 'auth'
      end
    end
  end
end
