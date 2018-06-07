# frozen_string_literal: true

shared_examples_for 'form with attachment' do
  it 'should create attachment' do
    expect do
      subject_with_file.save
    end.to change(Attachment, :count).by(1)
  end

  it 'should destroy attachment' do
    subject_with_file.save
    object = subject_with_file.object
    form2 = described_class.new(form_attributes(object))
    expect do
      form2.update
    end.to change(Attachment, :count).by(-1)
  end
end
