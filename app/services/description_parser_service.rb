# frozen_string_literal: true

class ParserError < StandardError; end

class DescriptionParserService < ApplicationService
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def call
    {
      author: extract_author,
      description: extract_description,
      maintainer: extract_maintainer,
      name: extract_name,
      published_at: extract_date_published,
      title: extract_title,
      version: extract_version
    }
  rescue StandardError => e
    Rails.logger.error "##### [#{self.class.name}][#{__method__}][Error] #{e} #####"
  end

  private

  def extract_author
    with_email = false
    authors = if data.include?('Authors@R')
                with_email = true
                data['Authors@R'].gsub(/["\t]/, '').split('person')
              else
                data['Author'].gsub(/(\[\w+,*\s*\w+\])/, '').split(',')
              end

    pkg_authors = {}

    authors.each do |author|
      name = author_name(author, with_email)
      email = author_email(author)
      pkg_authors[name] = email if name
    end

    pkg_authors
  end

  def extract_date_published
    data['Date/Publication']
  end

  def extract_description
    data['Description'].gsub(/\t/, '')
  end

  def extract_maintainer
    pkg_maintainer = {}
    data['Maintainer'].split(',').each do |str|
      maintainer = str.match(/([\w\s]+)<([\w\W]+)>/)
      pkg_maintainer['name'] = maintainer[1].strip
      pkg_maintainer['email'] = maintainer[2]
    end
    pkg_maintainer
  end

  def extract_name
    data['Package']
  end

  def extract_title
    data['Title']
  end

  def extract_version
    data['Version']
  end

  def author_name(str, with_email)
    return str.strip unless with_email

    name = str.match(/\((\w+,\s*\w+)/)
    name[1].gsub(',', '').strip if name
  end

  def author_email(str)
    email = str.match(/(?=)email\s*=\s*([\w.@]+)/)
    email[1] if email
  end
end
