class SerializerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def create_serializer_file
    template 'serializer.rb.tt', "app/serializers/#{file_name}_serializer.rb"
  end
end
