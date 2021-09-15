# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PackagesFetcherService do
  describe '#call' do
    subject { described_class.new }

    let(:pkgs) do
      [
        {
          'Package' => 'survival',
          'Version' => '3.2-13',
          'Priority' => 'recommended',
          'Depends' => 'R (>= 4.2)',
          'Imports' => 'graphics, Matrix, methods, splines, stats, utils',
          'License' => 'LGPL (>= 2)',
          'MD5sum' => '376c8bed4f200aa4e82b1aa1dd82e864',
          'NeedsCompilation' => 'yes',
          'Path' => '4.2.0/Recommended'
        },
        {
          'Package' => 'XML',
          'Version' => '3.99-0.7',
          'Depends' => 'R (>= 2.13.0), methods, utils',
          'Suggests' => 'bitops, RCurl',
          'License' => 'BSD_3_clause + file LICENSE',
          'MD5sum' => '424ade48afa7ab9da1ba5b9443b565ff',
          'NeedsCompilation' => 'yes',
          'Path' => 'Older'
        }
      ]
    end

    context 'when fetching packages is successful' do
      before { allow(subject).to receive(:call).and_return(pkgs) }

      it 'returns an array of package hashes' do
        packages = subject.call

        expect(packages).to be_an Array
        expect(packages.size).to eq(2)
      end
    end

    context 'when fetching packages is unsuccessful' do
      before { allow(subject).to receive(:call).and_raise(PackagesFetcherError) }

      it 'throws an error' do
        expect { subject.call }.to raise_error(PackagesFetcherError)
      end
    end
  end
end
