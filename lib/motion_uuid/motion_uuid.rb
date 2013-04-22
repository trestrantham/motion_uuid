module UUIDTools
  class UUID
    def self.parse_string(str)
      return nil if str.length == 0
      if str.length == 36
        parse str
      elsif str.length == 32
        parse_hexdigest str
      else
        parse_raw str
      end
    end
  end
end

module MotionUUID
  class UUID
    @@uuid_namespace = nil

    def self.uuid_namespace(namespace)
      namespace = UUIDTools::UUID.parse_string(namespace) unless namespace.is_a? UUID
      @@uuid_namespace = namespace
    end

    def self.create_uuid(text = nil)
      if text
        UUIDTools::UUID.sha1_create(@@uuid_namespace || UUIDTools::NameSpace_OID, text)
      else
        UUIDTools::UUID.random_create
      end
    end
  end
end
