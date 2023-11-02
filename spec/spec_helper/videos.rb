# frozen_string_literal: true

require 'eac_ruby_utils/fs/temp'
require 'ehbrs_ruby_utils/executables'

RSpec.configure do |config|
  config.before do
    videos_temp_dir
  end

  config.after do
    videos_temp_dir.remove
  end

  def videos_temp_dir
    @videos_temp_dir ||= EacRubyUtils::Fs::Temp.directory
  end

  def stub_video_source_file
    @stub_video_source_file ||= Pathname.new(__dir__).join('videos_files', 'stub_source.mp4')
  end

  def stub_video(ffmpeg_args, output_path = nil)
    output_path ||= videos_temp_dir.file
    EhbrsRubyUtils::Executables.ffmpeg.command.append(
      ['-i', stub_video_source_file.to_s, *ffmpeg_args, output_path.to_s]
    ).execute!

    output_path
  end
end
