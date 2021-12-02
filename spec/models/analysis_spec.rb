RSpec.describe Analysis, type: :model do
  describe 'db table' do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :resource }
    it { is_expected.to have_db_column :request_ip }
    it { is_expected.to have_db_column :results }
    it { is_expected.to have_db_column :category }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :category }
    it { is_expected.to validate_presence_of :resource }
  end
end
