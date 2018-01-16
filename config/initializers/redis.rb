if Rails.env.staging? || Rails.env.production?
  $redis = Redis.new(host: 'localhost', port: 6379)
else
  $redis = Redis.new(host: 'localhost', port: 6379)
end
#redis now is shared by several apps, mpp use 3
$redis.select(3)
