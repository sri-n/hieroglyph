module Hieroglyph

  class CharacterSheet

    attr_accessor :files, :output_path

    @@montage_args = {
      'background' => '#ffffff',
      'fill' => '#000000',
      'geometry' => '150x150+25+25',
      'label' => '%t',
      'mattecolor' => '#ffffff'
    }

    def initialize(options)
      @options = options
      @output_path = File.join(@options[:output_folder], @options[:name]) + '_characters.png'
      Hieroglyph.delete @output_path
      @files = []
      Hieroglyph.log 'ImageMagick detected - generating character sheet'
    end

    def add(file)
      @files.push file
    end

    def save
      cmd = 'montage'
      @@montage_args['title'] = @options[:name]
      @@montage_args.each do |arg, value|
        cmd << " -#{arg} #{value}"
      end
      @files.each do |file|
        cmd << " #{file}"
      end
      cmd << " #{@output_path}"
      `#{cmd}`
    end
  end

end
