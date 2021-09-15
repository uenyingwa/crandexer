# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Processes::BaseService do
  let(:fetch_service) { PackagesFetcherService.new }
  let(:extract_service) { PackageInfoExtractorService.new(packages[0]) }
  let(:parse_service) { DescriptionParserService.new(pkg_info[0]) }
  let(:packages) do
    [
      {
        'Package' => 'AATtools',
        'Version' => '3.2-13',
        'Priority' => 'recommended',
        'Depends' => 'R (>= 4.2)',
        'Imports' => 'graphics, Matrix, methods, splines, stats, utils',
        'License' => 'LGPL (>= 2)',
        'MD5sum' => '376c8bed4f200aa4e82b1aa1dd82e864',
        'NeedsCompilation' => 'yes',
        'Path' => '4.2.0/Recommended'
      }
    ]
  end
  let(:pkg_info) do
    [
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
    ]
  end
  let(:desc_info) do
    {
      author: {
        'Sercan Kahveci' => 'sercan.kahveci@sbg.ac.at'
      },
      description: 'Compute approach bias scores using different scoring algorithms.',
      maintainer: {
        'name' => 'Sercan Kahveci',
        'email' => 'sercan.kahveci@sbg.ac.at'
      },
      name: 'AATtools',
      published_at: '2020-06-14 15:10:06 UTC',
      title: 'Reliability and Scoring Routines for the Approach.',
      version: '0.0.1'
    }
  end

  describe '#call' do
    subject { described_class.new }

    let(:indexed_package) do
      {
        author: {
          'Jorn Lotsch' => nil,
          'Florian Lerch' => nil,
          'Michael Thrun' => 'm.thrun@gmx.net'
        },
        description: 'Supplies tools for tabulating and analyzing.',
        maintainer: {
          'name' => 'Michael Thrun',
          'email' => 'm.thrun@gmx.net'
        },
        name: 'A3',
        published_at:
             '2015-08-16 23:05:52.000000000 +0000',
        title: 'Accurate, Adaptable, and Accessible Error Metrics.',
        version: '1.0.0'
      }
    end

    context 'when indexing is successful' do
      it 'index a package' do
      end
    end

    context 'when indexing is unsuccessful' do
      it 'throws an error' do
        allow(subject).to receive(:call).and_raise(StandardError, 'Error occured')

        expect { subject.call }.to raise_error(StandardError, 'Error occured')
      end
    end
  end
end
