module Sprockets
  module Mime
    # Returns a `Hash` of mime types registered on the environment and those
    # part of `Rack::Mime`.
    attr_reader :mime_types

    # Register a new mime type.
    def register_mime_type(mime_type, ext)
      ext = Sprockets::Utils.normalize_extension(ext)
      @mime_types[ext] = mime_type
    end

    # Returns the correct encoding for a given mime type, while falling
    # back on the default external encoding, if it exists.
    def encoding_for_mime_type(type)
      encoding = Encoding::BINARY if type =~ %r{^(image|audio|video)/}
      encoding ||= Sprockets.default_external_encoding
      encoding
    end

    def matches_content_type?(mime_type, path)
      # TODO: Disallow nil mime type
      mime_type.nil? ||
        mime_type == "*/*" ||
        # TODO: Review performance
        mime_type == mime_types[parse_path_extnames(path)[1]]
    end
  end
end
