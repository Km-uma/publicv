FactoryBot.define do
  factory :education do
    started_on { Date.new(2008) }
    degree { 'Bachelor of Science' }
    description { 'Learned a lot' }
    ended_on { Date.new(2012) }
    school { 'ETH' }
  end
end
