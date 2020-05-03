# frozen_string_literal: true

shared_examples_for 'form with image' do
  it 'creates attachment' do
    expect do
      subject_with_file.save
    end.to change(Attachment, :count).by(1)
  end

  it 'destroys attachment' do
    subject_with_file.save
    model = subject_with_file.model
    form2 = described_class.new(form_attributes(model))
    expect do
      form2.update
    end.to change(Attachment, :count).by(-1)
  end
end
