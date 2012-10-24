# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory(:dvd) do
    name "M*A*S*H"
    asin "B00003CXB7"
    summary "M*A*S*H (1973)"
    director {create(:director)}
    actors {[create(:actor)]}
  end
end
