require 'spec_helper'

describe Note do
  let(:note) { Note.new(note: "test note")}
  it "saves notes" do
    expect(note.id).to_not be_nil
  end
end
