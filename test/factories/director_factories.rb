# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory(:director) do
    name "Robert Altman"
    gender "male"
    dob "02-20-1925"
  end
end
