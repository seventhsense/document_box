# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  process :textize, if: :is_document?

  version :thumb, if: :is_image? do
    process :cover, if: :is_pdf?
    process :resize_to_fit => [200, 200], if: :is_image?
    process :convert => 'jpg', if: :is_pdf?
  end

  def textize
    extname = File.extname current_path
    if extname == '.pdf'
      t = PdfToText.new current_path
      model.body = t.excute
    elsif extname == '.doc' or extname == '.docx'
      t = DocToText.new current_path
      model.body = t.excute
    end
  end

  def cover
    manipulate! do |frame, index|
      frame if index.zero?
    end
  end

  def is_image? file
    extname = File.extname current_path
    %[.jpg .jpeg .gif .png .pdf].include?(extname)
  end

  def is_pdf? file
    extname = File.extname current_path
    %[.pdf].include?(extname)
  end

  def is_document? file
    extname = File.extname current_path
    %[.pdf .doc .docx].include?(extname)
  end

  def is_doc? file
    extname = File.extname current_path
    %[.doc .docx].include?(extname)
  end


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png pdf doc docx)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
