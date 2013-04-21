# monkey-patch Friendly::UUID to serialize UUIDs
module UUIDTools
  module UUID
    alias_method :id, :raw

    # duck typing activerecord 3.1 dirty hack )
    def gsub *; self; end

    def quoted_id
      s = raw.unpack("H*")[0]
      "x'#{s}'"
    end

    def as_json(options = nil)
      hexdigest.upcase
    end

    def to_param
      hexdigest.upcase
    end

    def self.serialize(value)
      case value
      when self
        value
      when String
        parse_string value
      else
        nil
      end
    end

  private

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
  module UUID

    included do
      class_attribute :_uuid_namespace, instance_writer: false
      class_attribute :_uuid_generator, instance_writer: false
      self._uuid_generator = :random

      singleton_class.alias_method_chain :instantiate, :uuid
    end

    module ClassMethods
      def natural_key(*attributes)
        self._natural_key = attributes
      end

      def uuid_namespace(namespace)
        namespace = UUIDTools::UUID.parse_string(namespace) unless namespace.is_a? UUIDTools::UUID
        self._uuid_namespace = namespace
      end

      def uuid_generator(generator_name)
        self._uuid_generator = generator_name
      end

      def instantiate_with_uuid(record)
        uuid_columns.each do |uuid_column|
          record[uuid_column] = UUIDTools::UUID.serialize(record[uuid_column]).to_s if record[uuid_column]
        end
        instantiate_without_uuid(record)
      end

      def uuid_columns
        @uuid_columns ||= columns.select { |c| c.type == :uuid }.map(&:name)
      end
    end

    def create_uuid(salt = nil)
      if salt
        UUIDTools::UUID.sha1_create(_uuid_namespace || UUIDTools::UUID_OID_NAMESPACE, salt)
      else
        case _uuid_generator
        when :random
          UUIDTools::UUID.random_create
        when :time
          UUIDTools::UUID.timestamp_create
        end
      end
    end
  end
end
