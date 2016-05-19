class UserAvatarDownloaderJob < ActiveJob::Base
  queue_as :http_request

  rescue_from(CarrierWave::DownloadError) do
    retry_job wait: 5.seconds, queue: :low_priority
  end

  def perform(user)
    user.download_remote_avatar if user
  end
end
