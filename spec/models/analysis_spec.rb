RSpec.describe Analysis, type: :model do
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :resource }
  it { is_expected.to have_db_column :request_ip }
  it { is_expected.to have_db_column :results }
end
