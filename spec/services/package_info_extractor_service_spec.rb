# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PackageInfoExtractorService do
  describe '#call' do
    subject { described_class.new(pkg) }

    let(:pkg) do
      {
        'Package' => 'AATtools',
        'Version' => '0.0.1',
        'Depends' => 'R (>= 3.6.0)',
        'Imports' => 'magrittr, dplyr, doParallel, foreach',
        'License' => 'GPL-3',
        'MD5sum' => '376c8bed4f200aa4e82b1aa1dd82e864',
        'NeedsCompilation' => 'yes',
        'Path' => '4.2.0/Recommended'
      }
    end

    let(:description_info) do
      [
        {
          'Package' => 'AATtools',
          'Type' => 'Package',
          'Title' => 'Reliability and Scoring Routines for the Approach-Avoidance Task',
          'Version' => '0.0.1',
          'Authors@R' => 'person("Sercan", "Kahveci", email = "sercan.kahveci@sbg.ac.at", role = c("aut", "cre"))',
          'Description' => 'Compute approach bias scores using different scoring algorithms.',
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
      ]
    end

    context 'when fetching a package is successful' do
      before { allow(subject).to receive(:call).and_return(description_info) }

      it 'returns an array of description hashes' do
        packages = subject.call

        expect(packages).to be_an Array
        expect(packages[0]).to be_a Hash
        expect(packages[0]).to include('Maintainer')
      end
    end

    context 'when fetching package is unsuccessful' do
      before { allow(subject).to receive(:call).and_raise(StandardError, 'Error occurred') }

      it 'throws an error' do
        expect { subject.call }.to raise_error(StandardError, 'Error occurred')
      end
    end
  end
end
