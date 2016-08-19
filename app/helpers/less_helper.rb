module LessHelper

require 'fileutils'


  def to_less_file(theme)

    path = File.join Rails.root, 'public/less/'
    FileUtils.mkdir_p(path) unless File.exist?(path) 
    File.open(File.join("public/less/", "#{theme.name}#{theme.id}.less"), 'wb') do |file|
      file << theme.style.gsub(/\A"|"\Z/, '')
    end

    less_to_css(theme)

  end
  
  def less_to_css(theme)
    compiled_style = ''
    path = File.join Rails.root, 'public/dist/'
    FileUtils.mkdir_p(path) unless File.exist?(path) 
    File.open(File.join("public/dist/", "#{theme.name}#{theme.id}.css"), 'r') do |file|
      file.each_line { |line| compiled_style << line }
      file.close
    end
   
    if !compiled_style.nil?
      url = "#{Rails.root}/public/dist/#{theme.name}#{theme.id}.css"
    return url
    else
      return false
    end
  end

  
  def destroy_files(theme)
    if theme
      File.delete(Rails.root + "public/less/#{theme.name}#{theme.id}.less")
      File.delete(Rails.root + "public/dist/#{theme.name}#{theme.id}.css")
    return true
    else
      return false
    end
  end

end