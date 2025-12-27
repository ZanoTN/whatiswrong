module AfterAppStart
  def self.run
    create_settings_record

    create_default_app_whatiswrong
  end

  private

  def self.create_settings_record
    if Setting.count.zero?
      puts "Creating default Settings record..."
      Setting.create
    end
  end

  def self.create_default_app_whatiswrong
    if App.system_app.nil?
      puts "Creating default 'whatiswrong' App record..."
      App.create(name: "WhatIsWrong")
    end
  end
end