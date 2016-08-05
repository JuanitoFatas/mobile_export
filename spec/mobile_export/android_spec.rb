RSpec.describe MobileExport::Android do
  describe "#run" do
    def setup_android_images
      FileUtils.touch "spec/fixtures/android/base_m.png"
      FileUtils.touch "spec/fixtures/android/base_h.png"
      FileUtils.touch "spec/fixtures/android/base_xh.png"
      FileUtils.touch "spec/fixtures/android/base_xxh.png"
      FileUtils.touch "spec/fixtures/android/base_hhh.png"
    end

    def remove_file_if_exist?(path)
      FileUtils.rm(path) if File.exist?(path)
    end

    def cleanup
      remove_file_if_exist?("spec/fixtures/android/base_m.png")
      remove_file_if_exist?("spec/fixtures/android/base_h.png")
      remove_file_if_exist?("spec/fixtures/android/base_xh.png")
      remove_file_if_exist?("spec/fixtures/android/base_xxh.png")
      remove_file_if_exist?("spec/fixtures/android/base_hhh.png")

      FileUtils.rm_rf "spec/fixtures/android/drawable-hhhdpi"
      FileUtils.rm_rf "spec/fixtures/android/drawable-xxhdpi"
      FileUtils.rm_rf "spec/fixtures/android/drawable-xhdpi"
      FileUtils.rm_rf "spec/fixtures/android/drawable-hdpi"
      FileUtils.rm_rf "spec/fixtures/android/drawable-mdpi"
    end

    def expect_android_folders_to_be_created
      expect(File.directory?("spec/fixtures/android/drawable-hhhdpi")).to be true
      expect(File.directory?("spec/fixtures/android/drawable-xxhdpi")).to be true
      expect(File.directory?("spec/fixtures/android/drawable-xhdpi")).to be true
      expect(File.directory?("spec/fixtures/android/drawable-hdpi")).to be true
      expect(File.directory?("spec/fixtures/android/drawable-mdpi")).to be true
    end

    def expect_original_files_to_be_moved
      expect(File.exist?("spec/fixtures/android/base_m.png")).not_to be true
      expect(File.exist?("spec/fixtures/android/base_h.png")).not_to be true
      expect(File.exist?("spec/fixtures/android/base_xh.png")).not_to be true
      expect(File.exist?("spec/fixtures/android/base_xxh.png")).not_to be true
      expect(File.exist?("spec/fixtures/android/base_hhh.png")).not_to be true
    end

    def expect_original_files_moved_to_correct_location
      expect(File.exist?("spec/fixtures/android/drawable-hhhdpi/base.png")).to be true
      expect(File.exist?("spec/fixtures/android/drawable-xxhdpi/base.png")).to be true
      expect(File.exist?("spec/fixtures/android/drawable-xhdpi/base.png")).to be true
      expect(File.exist?("spec/fixtures/android/drawable-hdpi/base.png")).to be true
      expect(File.exist?("spec/fixtures/android/drawable-mdpi/base.png")).to be true
    end

    before { setup_android_images }

    it "organizae images for Android platform" do
      exporter = described_class.new("spec/fixtures/android")
      exporter.run

      expect_android_folders_to_be_created
      expect_original_files_to_be_moved
      expect_original_files_moved_to_correct_location
    end

    after { cleanup }
  end
end
