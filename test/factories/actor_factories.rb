# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory(:actor) do
    name "Alan Alda"
    gender "male"
    dob "01-28-1936"
  end
end
