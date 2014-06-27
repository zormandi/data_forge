require 'spec_helper'

describe DataForge::Transformation::RubyTransformationContext do

  describe "#output" do
    let(:record) { double "Record" }
    let(:writer1) { instance_double "DataForge::File::RecordFileWriter", name: :writer1 }
    let(:writer2) { instance_double "DataForge::File::RecordFileWriter", name: :writer2 }

    context "when the :to directive is not used" do
      it "should write the record into the record writer" do
        subject = described_class.new [writer1]

        expect(writer1).to receive(:write).with(record)

        subject.output record
      end

      it "should raise an error if there is more than 1 writer available" do
        subject = described_class.new [writer1, writer2]

        expect { subject.output record }.to raise_error "Missing :to directive for `output` command in multiple file transformation"
      end
    end


    context "when the :to directive is used" do
      subject { described_class.new [writer1, writer2] }

      it "should write the record into the specified writer, if there is only one" do
        expect(writer1).to receive(:write).with(record)

        subject.output record, to: :writer1
      end

      it "should write the record into all specified writers, if there is more than one" do
        expect(writer1).to receive(:write).with(record)
        expect(writer2).to receive(:write).with(record)

        subject.output record, to: [:writer1, :writer2]
      end

      it "should raise an error if an unrecognized target file is specified" do
        expect { subject.output record, to: :no_such_file }.to raise_error "Unknown target file 'no_such_file' for `output` command"
      end
    end
  end

end
