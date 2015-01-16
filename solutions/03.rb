module RBFS
  class File
    attr_accessor :data
    attr_accessor :data_type

    def initialize (start_data = nil)
      @data = start_data
      set_data_type(start_data)
    end

    def data=(new_data)
      @data = new_data
      set_data_type(new_data)
    end

    def data_type=(new_type)
      @data_type = new_type
      case new_type
      when :nil then @data = nil
      when :string then @data = @data.to_s
      when :number then @data = @data.to_f
      when :symbol then @data = @data.to_sym
      when :boolean then @data = @data == "true"
      end
    end

    def serialize
      @data_type.to_s + ":" + @data.to_s
    end

    def File.parse(parse_string)
      ret = File.new
      ret.data = parse_string.split(":")[1]
      ret.data_type = parse_string.split(":")[0].to_sym
      ret
    end

    private

    def set_data_type(start_data)
      case start_data
      when NilClass then @data_type = :nil
      when String then @data_type = :string
      when Integer, Float then @data_type = :number
      when Symbol then @data_type = :symbol
      when TrueClass, FalseClass then @data_type = :boolean
      end
    end
  end

  class Directory
    attr :files, true
    attr :directories, true

    def initialize
       @files =  Hash.new
       @directories = Hash.new
    end

    def add_file(file_name, file_data)
      @files[file_name] = file_data
    end

    def add_directory(directory_name, directory_data = RBFS::Directory.new)
      @directories[directory_name] = directory_data
    end

    def serialize
       ret = @files.size.to_s.concat(":")
       @files.each_pair{ |a, b|
                        ret << a << ":" << b.serialize.length.to_s << ":" << b.serialize }
       ret << @directories.size.to_s << ":"
       @directories.each_pair{ | a, b | #Skeptic:Space=symbol, Style Guide align conflict
                        ret << a << ":" << b.serialize.length.to_s << ":" << b.serialize }
      ret
    end

    def [](index_name)
        ret = @files[index_name] || @directories[index_name]
    end

    def Directory.parse( parse_string)
      return_dir = RBFS::Directory.new
      parser = Parser.new(parse_string)
      parser.first_parts.each_pair{ | name , data |
                                  return_dir.add_file(name, File.parse(data)) }
      parser.second_parts.each_pair{ | name , data | #Same problem with Skeptic
                                  return_dir.add_directory(name, Directory.parse(data)) }
      return_dir
    end

  end
  class Parser
    attr_reader :first_parts
    attr_reader :second_parts

    def initialize (parse_string)
       @first_parts, @second_parts =  Hash.new, Hash.new
       parse(parse_string)
    end

    def parse(parse_string)
      @string  = parse_string
      parse_helper(@first_parts)
      parse_helper(@second_parts)
    end

    private

    def parse_helper(part_colector)
       part_count = @string.split(":")[0].to_i
       @string = @string[ part_count.to_s.length+1 .. @string.length]
       parse_split_parts(part_colector, part_count)
    end

    def parse_split_parts (part_colector, part_count)
      return if part_count == 0
      part_name, part_size = @string.split(":")[0], @string.split(":")[1].to_i
      @string = @string[part_name.length + part_size.to_s.length + 2 .. @string.length]
      part_colector[part_name] = @string[0..part_size - 1]
      @string = @string[part_size..@string.length]
      parse_split_parts(part_colector, part_count - 1)
    end
  end
end