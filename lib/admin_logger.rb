class AdminLogger < Logger
  def format_message(severity, timestamp, progname, msg)
    "#{timestamp.to_formatted_s(:db)} #{severity} #{msg}\n"
  end
end
# create log file
log_dir = "#{Rails.root}/" + Settings.logs.log_dir
FileUtils.mkdir_p(log_dir) unless File.exist?(log_dir)
logfile = File.open "#{Rails.root}/" + Settings.logs.admin_log_path, "a"
logfile.sync = true  # automatically flushes data to file
ADMIN_LOGGER = AdminLogger.new(logfile)  # constant accessible anywhere
