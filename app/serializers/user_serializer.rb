module UserSerializer
  include Serializer

  private

  def attributes
    { id:, username:, name:, email:, image: }
  end
end
