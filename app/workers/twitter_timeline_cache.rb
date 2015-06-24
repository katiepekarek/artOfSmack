class TwitterTimelineCache
  include Sidekiq::Worker
  sidekiq_options queue: "high"
  # sidekiq_options retry: false

  def perform
    client.home_timeline(:count => 149).map do |event|
      event.class.send(:define_method, :class_name) do
        parse_type(event.class)
      end
      event
    end
  end
end
