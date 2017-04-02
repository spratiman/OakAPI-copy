module StaticPagesHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def gravatar_for(current_user, args = {})
    gravatar_id = Digest::MD5::hexdigest(current_user.email.downcase)
    size = args.has_key?(:size) ? "?s=#{args[:size]}" : ""
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}#{size}"
    classes = args.has_key?(:class) ? args[:class] : ""
    image_tag(gravatar_url, alt: current_user.first_name, :class => classes)
  end
end
