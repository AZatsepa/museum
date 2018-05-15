describe Comment, type: :model do
  it { should belong_to :user }
  it { should belong_to :post }

  it { should validate_presence_of :user }
  it { should validate_presence_of :post }
  it { should validate_presence_of :text }
end
