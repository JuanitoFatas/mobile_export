require "pathname"
require "fileutils"

module MobileExport
  class Android
    def initialize(current_directory = Pathname.getwd)
      @current_directory = Pathname(current_directory)
    end

    def run
      create_directories!
      move_images!
    end

    private

      attr_reader :current_directory

      SUFFIX_FOLDER = {
        "hhh" => "drawable-hhhdpi",
        "xxh" => "drawable-xxhdpi",
        "xh"  => "drawable-xhdpi",
        "h"   => "drawable-hdpi",
        "m"   => "drawable-mdpi",
      }

      IMAGE_EXTENSIONS = %w(png jpg jpeg)

      private_constant :SUFFIX_FOLDER
      private_constant :IMAGE_EXTENSIONS

      def create_directories!
        SUFFIX_FOLDER.values.each do |directory|
          path = current_directory.join directory

          FileUtils.mkdir_p(path) if !path.directory?
        end
      end

      def image_patterns_for_glob
        @_image_patterns_for_glob ||= begin
          current_directory.join("*.{#{IMAGE_EXTENSIONS.join(",".freeze)}}").to_s
        end
      end

      def image_patterns
        @_image_patterns ||= Regexp.compile(IMAGE_EXTENSIONS.join("|".freeze))
      end

      def all_image_files
        @_all_image_files = Dir[image_patterns_for_glob]
      end

      def move_images!
        SUFFIX_FOLDER.each do |suffix, folder|
          destination = current_directory.join(folder)
          files_with_suffix = all_image_files.select do |file|
            file =~ /_#{suffix}\.(#{image_patterns})$/
          end

          files_with_suffix.each do |file|
            matched = Pathname(file).basename.to_s.match(
              /(?<filename>.*)_(?<suffix>(#{suffix}))(?<extension>\..*)$/
            )
            old_path = file
            new_path = destination.join(matched[:filename] + matched[:extension]).to_s

            puts "Move #{old_path} to #{new_path}."
            FileUtils.mv old_path, new_path
          end
        end
      end
  end
end
