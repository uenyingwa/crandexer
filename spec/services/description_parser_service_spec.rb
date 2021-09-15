# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DescriptionParserService do
  describe '#call' do
    subject { described_class.new(data) }

    let(:data) do
      {
        'Package' => 'AATtools',
        'Type' => 'Package',
        'Title' => 'Reliability and Scoring Routines for the Approach-Avoidance Task',
        'Version' => '0.0.1',
        'Authors@R' => 'person("Sercan", "Kahveci", email = "sercan.kahveci@sbg.ac.at", role = c("aut", "cre"))',
        'Description' => 'Compute approach bias scores using different scoring algorithms, compute bootstrapped and exact split-half reliability estimates, and compute confidence intervals for individual participant scores.',
        'Depends' => 'R (>= 3.6.0)',
        'Imports' => 'magrittr, dplyr, doParallel, foreach',
        'License' => 'GPL-3',
        'Encoding' => 'UTF-8',
        'BugReports' => 'https://github.com/Spiritspeak/AATtools/issues',
        'LazyData' => 'true',
        'ByteCompile' => 'true',
        'RoxygenNote' => '7.1.0',
        'NeedsCompilation' => 'no',
        'Packaged' => '2020-06-09 16:49:30 UTC; b1066151',
        'Author' => 'Sercan Kahveci [aut, cre]',
        'Maintainer' => 'Sercan Kahveci <sercan.kahveci@sbg.ac.at>',
        'Repository' => 'CRAN',
        'Date/Publication' => '2020-06-14 15:10:06 UTC'
      }
    end

    context 'when description parsing is successful' do
      it 'returns a hash with package attributes' do
        attrs = subject.call

        expect(attrs).to be_a Hash
        expect(attrs[:name]).to eq('AATtools')
        expect(attrs[:author]).to be_a Hash
        expect(attrs).to include(:maintainer)
      end
    end

    context 'when description parsing is unsuccessful' do
      it 'throws an error' do
        allow(subject).to receive(:call).and_raise(StandardError, 'Error occured')

        expect { subject.call }.to raise_error(StandardError, 'Error occured')
      end
    end
  end
end
